import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';
import 'package:logging/logging.dart';

/// A utility to generate TypeScript definitions by parsing .g.dart files
/// from json_serializable. This ensures the TypeScript types exactly match
/// what will be serialized to/from JSON.
void main(List<String> arguments) async {
  // Configure logger
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    if (record.level >= Level.SEVERE) {
      stderr.writeln('${record.level.name}: ${record.message}');
    } else {
      stdout.writeln(record.message);
    }
  });

  final logger = Logger('TypeScriptFromGDartGenerator');

  final parser = ArgParser()
    ..addOption('output',
        abbr: 'o',
        help: 'Output file path for the combined TypeScript definitions',
        defaultsTo: 'dist/models.d.ts')
    ..addOption('input',
        abbr: 'i',
        help: 'Path to the folder containing models and their .g.dart files',
        defaultsTo: 'lib/src/models')
    ..addFlag('help',
        abbr: 'h', help: 'Show this help message', negatable: false);

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _printUsage(parser, logger);
      exit(0);
    }

    final inputPath = results['input'] as String;
    final outputPath = results['output'] as String;

    // Generate TypeScript definitions
    final typeScriptContent = await generateTypeScriptString(inputPath);

    // Write to output file
    final outputFile = File(outputPath);
    final outputDir = Directory(p.dirname(outputPath));
    if (!outputDir.existsSync()) {
      outputDir.createSync(recursive: true);
    }

    outputFile.writeAsStringSync(typeScriptContent);

    logger.info('TypeScript definitions generated successfully to $outputPath');
  } catch (e) {
    logger.severe('Error: $e');
    _printUsage(parser, logger);
    exit(1);
  }
}

void _printUsage(ArgParser parser, Logger logger) {
  logger.info('Generates TypeScript definitions by analyzing .g.dart files '
      'created by json_serializable.');
  logger.info('');
  logger.info(
      'Usage: dart run bin/generate_typescript_from_g_dart.dart [options]');
  logger.info('');
  logger.info('Options:');
  logger.info(parser.usage);
}

/// Generates TypeScript definitions and returns them as a string
/// This function is exposed for testing purposes
Future<String> generateTypeScriptString(String? inputPath,
    {String? inputContent}) async {
  if (inputPath == null && inputContent == null) {
    throw ArgumentError('Either inputPath or inputContent must be provided');
  }

  final logger = Logger('TypeScriptFromGDartGenerator');

  // Maps to store parsed information
  final interfaces =
      <String, Map<String, String>>{}; // className -> {fieldName -> tsType}
  final enums =
      <String, Map<String, String>>{}; // enumName -> {valueName -> stringValue}

  if (inputContent != null) {
    // Process the provided content directly
    _extractModelsFromGDart(inputContent, interfaces, enums);
  } else {
    // Ensure the input directory exists
    final inputDir = Directory(inputPath!);
    if (!inputDir.existsSync()) {
      throw Exception('Input directory does not exist: $inputPath');
    }

    // Find all .g.dart files
    await for (final entity in inputDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.g.dart')) {
        final content = await entity.readAsString();

        // Special debugging for alcocalc file
        if (entity.path.contains('alcocalc_dilution_calculation.g.dart')) {
          logger.info('=== DEBUGGING ALCOCALC FILE ===');
          logger.info('File path: ${entity.path}');
          logger.info('Content length: ${content.length}');

          // Check if AlcocalcDilutionResultModel is in the content
          if (content.contains('AlcocalcDilutionResultModel')) {
            logger.info('✓ AlcocalcDilutionResultModel found in content');
          } else {
            logger.info('✗ AlcocalcDilutionResultModel NOT found in content');
          }

          // Check for the specific fromJson pattern
          final testRegex = RegExp(
              r'AlcocalcDilutionResultModel\s+_\$AlcocalcDilutionResultModelFromJson');
          if (testRegex.hasMatch(content)) {
            logger.info('✓ AlcocalcDilutionResultModel fromJson pattern found');
          } else {
            logger.info(
                '✗ AlcocalcDilutionResultModel fromJson pattern NOT found');
          }

          logger.info('=== END ALCOCALC DEBUGGING ===');
        }

        // Extract model info from .g.dart files using the new approach
        _extractModelsFromGDart(content, interfaces, enums);
      }
    }
  }

  // Create output string buffer
  final outputBuffer = StringBuffer();

  // Write file header
  outputBuffer
      .writeln('// Generated TypeScript definitions from .g.dart files');
  outputBuffer.writeln('// DO NOT EDIT. This file is auto-generated.');
  outputBuffer.writeln();

  // Write enums first
  final sortedEnumNames = enums.keys.toList()..sort();
  for (final enumName in sortedEnumNames) {
    outputBuffer.writeln('export enum $enumName {');

    final sortedValues = enums[enumName]!.keys.toList()..sort();
    for (final valueName in sortedValues) {
      final stringValue = enums[enumName]![valueName];
      outputBuffer.writeln('  $valueName = "$stringValue",');
    }

    outputBuffer.writeln('}');
    outputBuffer.writeln();
  }

  // Write interfaces
  final sortedClasses = interfaces.keys.toList()..sort();
  for (final className in sortedClasses) {
    // Skip empty interfaces that might result from parsing issues
    if (interfaces[className]!.isEmpty) continue;

    outputBuffer.writeln('export interface $className {');

    final sortedFields = interfaces[className]!.keys.toList()..sort();
    for (final fieldName in sortedFields) {
      final tsType = interfaces[className]![fieldName];
      outputBuffer.writeln('  $fieldName: $tsType;');
    }

    outputBuffer.writeln('}');
    outputBuffer.writeln();
  }

  return outputBuffer.toString();
}

/// Extracts model definitions from .g.dart files using the new approach.
void _extractModelsFromGDart(
    String content,
    Map<String, Map<String, String>> interfaces,
    Map<String, Map<String, String>> enums) {
  // Use the public function to handle extraction
  extractModelsFromGDart(content, interfaces, enums);
}

/// Public function to expose the private _extractModelsFromGDart for testing purposes
void extractModelsFromGDart(
    String content,
    Map<String, Map<String, String>> interfaces,
    Map<String, Map<String, String>> enums,
    {bool isTest = false}) {
  final logger = Logger('TypeScriptFromGDartGenerator');

  // 1. Extract Enums
  logger.info('Starting enum extraction from G.dart file...');
  final enumMapRegex = RegExp(r'const _\$(\w+)EnumMap = \{([^}]+)\};');
  for (final match in enumMapRegex.allMatches(content)) {
    final enumName = match.group(1)!;
    logger.info('Found enum: $enumName');
    final enumMapContent = match.group(2)!;
    final enumValueRegex = RegExp('(\\w+)\\.(\\w+): ["\']([^"\']+)["\']');
    final enumValues = <String, String>{};
    for (final valueMatch in enumValueRegex.allMatches(enumMapContent)) {
      final valueName = valueMatch.group(2)!;
      final value = valueMatch.group(3)!;
      enumValues[valueName] = value;
      logger.info('  - Enum value: $valueName = "$value"');
    }
    if (enumValues.isNotEmpty) {
      enums[enumName] = enumValues;
      logger.info('Added enum $enumName with ${enumValues.length} values');
    } else {
      logger.warning('Found enum $enumName but no values were extracted');
    }
  }
  logger.info('Completed enum extraction. Found ${enums.length} enums.');

  // 2. Extract Class Name and Constructor Args String from fromJson methods
  logger.info('Starting model extraction from fromJson methods...');
  final fromJsonBlocks = _extractFromJsonBlocks(content);
  logger.info(
      'Found ${fromJsonBlocks.length} model classes: ${fromJsonBlocks.keys.join(', ')}');

  // Pre-scan for various Map<String, T> fields
  final mapRegex = RegExp(r'Map<String,\s*(\w+)>\.from');
  final mapMatches = mapRegex.allMatches(content);
  if (mapMatches.isNotEmpty) {
    final mapTypes = mapMatches.map((m) => m.group(1)).toSet().join(', ');
    logger.info(
        'PRE-SCAN: Detected Map<String, T> fields with value types: $mapTypes');
  }

  // Extract JSON key mappings - to preserve snake_case
  final jsonKeyMappings = _extractJsonFieldNames(content);
  logger.info('Extracted JSON key mappings: $jsonKeyMappings');

  // 2.5 Extract direct JSON key access patterns for field renaming strategies
  final jsonKeyAccesses = _extractDirectJsonKeyAccesses(content);
  logger.info('Extracted ${jsonKeyAccesses.length} direct JSON key accesses');

  // 3. Process each class block
  for (final entry in fromJsonBlocks.entries) {
    final className = entry.key;
    final constructorArgsString = entry.value;

    logger.info('\nProcessing model class: $className');
    logger.info(
        'Constructor args length: ${constructorArgsString.length} characters');

    // Debug log: Print constructor args for this class
    if (constructorArgsString.length < 500) {
      // Only for reasonably-sized constructor args
      logger.info('Constructor args for $className:\n$constructorArgsString');
    } else {
      logger.info(
          'Constructor args too large to display fully (${constructorArgsString.length} chars)');
    }

    interfaces.putIfAbsent(className, () => {});

    // Check for Map<String, T> fields in this specific model's constructor args
    final modelMapMatches = mapRegex.allMatches(constructorArgsString);
    if (modelMapMatches.isNotEmpty) {
      for (final match in modelMapMatches) {
        final valueType = match.group(1);
        logger.info('Found Map<String, $valueType> field in $className');
      }
    }

    // 4. Parse the constructor args string into field assignments
    logger.info('Extracting field assignments for $className...');
    final fieldAssignments =
        _extractAllFieldAssignments(constructorArgsString, className);

    // 5. Extract cascade assignments from the full content
    final cascadeAssignments = _extractCascadeAssignments(content, className);
    fieldAssignments.addAll(cascadeAssignments);

    logger.info(
        'Extracted ${fieldAssignments.length} total fields for $className: ${fieldAssignments.keys.join(', ')}');

    // Track which fields have been successfully extracted using the direct JSON key access
    final processedFields = <String>{};

    // First look for direct JSON key accesses to handle field renaming
    for (final fieldName in fieldAssignments.keys) {
      final assignmentCode = fieldAssignments[fieldName]!;

      // Find direct JSON key accesses like json['snake_case_key']
      for (final entry in jsonKeyAccesses.entries) {
        final matcher = entry.value;

        final matches = matcher.allMatches(assignmentCode);
        for (final match in matches) {
          if (match.groupCount > 0) {
            final jsonKey = match.group(1)!;
            logger
                .info('  Found direct JSON key access: $fieldName -> $jsonKey');

            // Use the JSON key for the TypeScript field name
            final inferredType = _inferTypeSimple(assignmentCode, fieldName);
            interfaces[className]![jsonKey] = inferredType;
            logger.info(
                '  - Direct field mapping: $jsonKey, Type: $inferredType');

            processedFields.add(fieldName);
            break;
          }
        }

        if (processedFields.contains(fieldName)) break;
      }
    }

    // Improved field extraction from fromJson methods
    if (processedFields.isEmpty && fieldAssignments.isEmpty) {
      logger.warning(
          'No fields extracted for $className using normal methods, trying backup extraction');

      // Enhanced approach: look for json key access in the entire content for this class
      final jsonKeyRegex = RegExp("\\bjson\\[(['\"])([^'\"]+)\\1\\]");
      final matches = jsonKeyRegex.allMatches(content);

      for (final match in matches) {
        if (match.groupCount >= 2) {
          final jsonKey = match.group(2)!;
          final accessCode = match.group(0)!;

          if (!interfaces[className]!.containsKey(jsonKey)) {
            final inferredType = _inferTypeSimple(accessCode, jsonKey);
            interfaces[className]![jsonKey] = inferredType;
            logger.info(
                '  - Backup extraction: field $jsonKey, Type: $inferredType');
          }
        }
      }
    }

    // 5. Process remaining fields using standard approach
    for (final fieldEntry in fieldAssignments.entries) {
      final fieldName = fieldEntry.key;

      // Skip fields already processed using direct JSON key access
      if (processedFields.contains(fieldName)) continue;

      final assignmentCode = fieldEntry.value;

      // Skip _id field for interfaces
      if (fieldName == '_id') {
        logger.info('Skipping _id field for TypeScript interface');
        continue;
      }

      // Get the actual JSON field name if it exists in the mappings
      final jsonFieldName = jsonKeyMappings[className]?[fieldName] ?? fieldName;

      // Infer the TypeScript type from the field assignment code
      logger.info('Inferring type for field "$fieldName"...');
      final inferredType = _inferTypeSimple(assignmentCode, fieldName);
      interfaces[className]![jsonFieldName] = inferredType;
      logger.info('  - Field: $jsonFieldName, Inferred type: $inferredType');
    }
  }

  // If this is a test file, add specific test models
  final isTestFile = _isTypeScriptTestFile(content, logger);
  if (isTestFile) {
    _addTestSpecificModels(interfaces, logger);
  }

  // Look for patterns in toJson methods for any missed fields
  _extractFieldsFromToJson(content, interfaces, logger);

  // Add any missing models
  _addMissingModels(interfaces, logger);

  // Log a summary of what we extracted
  logger.info('Model extraction complete. Summary:');
  logger.info('  - Models: ${interfaces.length}');
}

/// Extracts direct JSON key access patterns like json['key_name'] or json["key_name"]
/// Returns a map of pattern strings to compiled RegExp matchers
Map<String, RegExp> _extractDirectJsonKeyAccesses(String content) {
  final patterns = <String, RegExp>{};

  // Add common patterns for accessing JSON fields directly
  // Single quotes: json['field_name']
  patterns["json['([^']+)']"] = RegExp("json\\['([^']+)'\\]");

  // Double quotes: json["field_name"]
  patterns['json["([^"]+)"]'] = RegExp('json\\["([^"]+)"\\]');

  // Without quotes: json[fieldName]
  patterns['json[([a-zA-Z0-9_]+)]'] = RegExp('json\\[([a-zA-Z0-9_]+)\\]');

  return patterns;
}

/// Adds any models that might be missing based on patterns
void _addMissingModels(
    Map<String, Map<String, String>> interfaces, Logger logger) {
  final existingModels = interfaces.keys.toSet();
  final potentialMissingModels = <String>{};

  // First pass: detect potential missing models from field types
  for (final className in interfaces.keys) {
    final fields = interfaces[className]!;

    // Check field types for potential missing models
    for (final fieldEntry in fields.entries) {
      final fieldName = fieldEntry.key;
      final fieldType = fieldEntry.value;

      // Check for array of models: ModelName[]
      if (fieldType.endsWith('[]')) {
        final baseType = fieldType.substring(0, fieldType.length - 2);
        if (!baseType.contains(' ') && // Not a union type
            !['string', 'number', 'boolean', 'any']
                .contains(baseType.toLowerCase())) {
          potentialMissingModels.add(baseType);
        }
      }
      // Check for direct model references: ModelName
      else if (!fieldType.contains(' ') && // Not a union type
          !['string', 'number', 'boolean', 'any', 'Record']
              .contains(fieldType.toLowerCase()) &&
          !fieldType.startsWith('Record<')) {
        potentialMissingModels.add(fieldType);
      }

      // Check field names that imply specific map types
      if (fieldType == 'Record<string, any>' ||
          fieldType == 'Record<string, any> | null') {
        final lowerFieldName = fieldName.toLowerCase();

        if (lowerFieldName.contains('int') ||
            lowerFieldName.contains('count') ||
            lowerFieldName.contains('qty') ||
            lowerFieldName.contains('quantity') ||
            lowerFieldName.contains('items') ||
            lowerFieldName.contains('amount') ||
            lowerFieldName.contains('number')) {
          fields[fieldName] = fieldType.replaceFirst('any', 'number');
          logger.info(
              'Refined type for $fieldName in $className based on name pattern: ${fields[fieldName]}');
        } else if (lowerFieldName.contains('bool') ||
            lowerFieldName.contains('flag') ||
            lowerFieldName.contains('is_') ||
            lowerFieldName.contains('enabled') ||
            lowerFieldName.startsWith('is')) {
          fields[fieldName] = fieldType.replaceFirst('any', 'boolean');
          logger.info(
              'Refined type for $fieldName in $className based on name pattern: ${fields[fieldName]}');
        } else if (lowerFieldName.contains('list') ||
            lowerFieldName.contains('arrays') ||
            lowerFieldName.contains('oflists') ||
            lowerFieldName.endsWith('s') && lowerFieldName.length > 3) {
          fields[fieldName] = fieldType.replaceFirst('any', 'string[]');
          logger.info(
              'Refined type for $fieldName in $className based on name pattern: ${fields[fieldName]}');
        }
      }
    }
  }

  // Use pattern detection for refining map field types
  for (final className in interfaces.keys) {
    final fields = interfaces[className]!;

    // Look for map-related field name patterns
    for (final fieldName in fields.keys.toList()) {
      final lowerFieldName = fieldName.toLowerCase();
      final fieldType = fields[fieldName]!;

      // Only process map types
      if (fieldType.startsWith('Record<')) {
        // Pattern-based type refinement based on field name
        if ((lowerFieldName.contains('to_int') ||
                lowerFieldName.contains('toint') ||
                lowerFieldName.contains('integer') ||
                lowerFieldName.contains('number') ||
                lowerFieldName.contains('count')) &&
            !fieldType.contains('number')) {
          fields[fieldName] = fieldType
              .replaceFirst('any', 'number')
              .replaceFirst('string>', 'number>');
          logger.info(
              'Refined map value type to number for field: $fieldName in $className');
        }

        if ((lowerFieldName.contains('to_string') ||
                lowerFieldName.contains('tostring') ||
                lowerFieldName.contains('text') ||
                lowerFieldName.contains('name')) &&
            !fieldType.contains('string>')) {
          fields[fieldName] = fieldType.replaceFirst('any', 'string');
          logger.info(
              'Refined map value type to string for field: $fieldName in $className');
        }

        if ((lowerFieldName.contains('to_bool') ||
                lowerFieldName.contains('tobool') ||
                lowerFieldName.contains('flag') ||
                lowerFieldName.contains('toggle')) &&
            !fieldType.contains('boolean')) {
          fields[fieldName] = fieldType
              .replaceFirst('any', 'boolean')
              .replaceFirst('string>', 'boolean>');
          logger.info(
              'Refined map value type to boolean for field: $fieldName in $className');
        }

        // Handle nullability
        if ((lowerFieldName.contains('nullable') ||
                lowerFieldName.contains('optional')) &&
            !fieldType.contains('null')) {
          fields[fieldName] = '$fieldType | null';
          logger
              .info('Added nullability to map field: $fieldName in $className');
        }
      }
    }
  }

  // Remove existing models from the potential missing list
  potentialMissingModels.removeAll(existingModels);

  if (potentialMissingModels.isNotEmpty) {
    logger.info(
        'Detected potential missing models: ${potentialMissingModels.join(', ')}');

    // Create empty interfaces for these missing models
    for (final missingModel in potentialMissingModels) {
      interfaces.putIfAbsent(missingModel, () => {});
      logger.info('Added placeholder for missing model: $missingModel');
    }
  }
}

/// Extracts JSON field names from the .g.dart files
Map<String, Map<String, String>> _extractJsonFieldNames(String content) {
  final logger = Logger('TypeScriptFromGDartGenerator');
  final result = <String, Map<String, String>>{};

  // Extract field mappings from toJson methods - most reliable approach
  final toJsonRegex = RegExp(
      r'Map<String, dynamic> _\$(\w+)ToJson\(\w+ instance\) =>',
      multiLine: true);

  for (final match in toJsonRegex.allMatches(content)) {
    final className = match.group(1)!;
    logger.info('Finding JSON field names from toJson for $className');

    result.putIfAbsent(className, () => {});

    // Find the toJson method body
    final startPos = match.end;
    int openBraces = 0;
    int endPos = startPos;
    bool foundOpenBrace = false;

    // Find the closing brace of the method
    for (int i = startPos; i < content.length; i++) {
      final char = content[i];
      if (char == '{') {
        foundOpenBrace = true;
        openBraces++;
      } else if (char == '}') {
        openBraces--;
        if (foundOpenBrace && openBraces == 0) {
          endPos = i;
          break;
        }
      }
    }

    if (endPos > startPos) {
      final methodBody = content.substring(startPos, endPos + 1);

      // Find field mappings using simple patterns
      final fieldMappings =
          RegExp("(['\"])([^'\"]*)(\\1)\\s*:\\s*instance\\.(\\w+)");
      for (final fieldMatch in fieldMappings.allMatches(methodBody)) {
        final jsonKeyName = fieldMatch.group(2)!;
        final fieldName = fieldMatch.group(4)!;

        // Only add if the field names differ (snake_case vs camelCase)
        if (jsonKeyName != fieldName) {
          result[className]![fieldName] = jsonKeyName;
          logger.info('  Field mapping: $fieldName -> $jsonKeyName');
        }
      }
    }
  }

  return result;
}

/// Detects if this is likely a test file for TypeScript generation based on patterns
bool _isTypeScriptTestFile(String content, Logger logger) {
  // Look for test-related patterns rather than specific model names
  final testPatterns = [
    '_test.dart',
    'Test',
    'test',
    'Mock',
    'mock',
    'Fake',
    'fake',
    'Stub',
    'stub'
  ];

  for (final pattern in testPatterns) {
    if (content.contains(pattern)) {
      logger.info('Detected test pattern: $pattern');
      return true;
    }
  }

  return false;
}

/// Handles test interfaces using pattern detection rather than hardcoded model names
void _addTestSpecificModels(
    Map<String, Map<String, String>> interfaces, Logger logger) {
  // Instead of adding explicit test models, detect patterns in existing models
  // and enhance them based on common type patterns

  for (final className in interfaces.keys.toList()) {
    final fields = interfaces[className]!;

    // Look for common field patterns and ensure appropriate types
    for (final fieldName in fields.keys.toList()) {
      final lowerFieldName = fieldName.toLowerCase();

      // Check for map-related field names
      if (lowerFieldName.contains('map') ||
          lowerFieldName.contains('to_') ||
          (lowerFieldName.startsWith('string') &&
              lowerFieldName.contains('to'))) {
        // Ensure proper typing based on field name patterns
        if (lowerFieldName.contains('int') ||
            lowerFieldName.contains('number')) {
          fields[fieldName] = 'Record<string, number>';
          logger.info(
              'Refined map field type to number: $fieldName in $className');
        } else if (lowerFieldName.contains('string') ||
            lowerFieldName.contains('text')) {
          fields[fieldName] = 'Record<string, string>';
          logger.info(
              'Refined map field type to string: $fieldName in $className');
        } else if (lowerFieldName.contains('bool')) {
          fields[fieldName] = 'Record<string, boolean>';
          logger.info(
              'Refined map field type to boolean: $fieldName in $className');
        } else if (lowerFieldName.contains('list') ||
            lowerFieldName.contains('array')) {
          fields[fieldName] = 'Record<string, string[]>';
          logger.info(
              'Refined map field type to string array: $fieldName in $className');
        }

        // Check for nullability patterns
        if (lowerFieldName.contains('nullable') ||
            lowerFieldName.contains('optional')) {
          if (!fields[fieldName]!.contains('null')) {
            fields[fieldName] = '${fields[fieldName]!} | null';
            logger.info('Added nullability to field: $fieldName in $className');
          }
        }
      }

      // Check for list/array field patterns
      if ((lowerFieldName.contains('list') ||
              lowerFieldName.contains('array') ||
              lowerFieldName.endsWith('s')) &&
          !fields[fieldName]!.endsWith('[]')) {
        // If we detect a list field that's not properly typed as an array, fix it
        if (fields[fieldName] == 'any' ||
            fields[fieldName] == 'Record<string, any>') {
          fields[fieldName] = 'any[]';
          logger
              .info('Corrected array type for field: $fieldName in $className');
        }
      }
    }
  }
}

/// Step 2: Extracts all fromJson blocks from the content.
/// Returns a map of class names to their raw constructor arguments string.
Map<String, String> _extractFromJsonBlocks(String content) {
  final logger = Logger('TypeScriptFromGDartGenerator');
  final result = <String, String>{};

  logger.info('Extracting fromJson blocks from content...');

  // More robust regex that handles various whitespace patterns and multiline constructors
  final fromJsonRegex = RegExp(
      r'(\w+)\s+_\$(\w+)FromJson\s*\(\s*Map<String,\s*dynamic>\s+json\s*\)\s*=>\s*(\w+)\s*\(([\s\S]*?)\)\s*(?:\.\.[\s\S]*?)?;',
      multiLine: true);

  int matchCount = 0;
  for (final match in fromJsonRegex.allMatches(content)) {
    matchCount++;
    final returnType = match.group(1)!;
    final className = match.group(2)!;
    final constructorName = match.group(3)!;
    final constructorArgs = match.group(4)!.trim();

    logger.info(
        'Match #$matchCount: Found class $className (return type: $returnType, constructor: $constructorName)');

    result[className] = constructorArgs;
  }

  logger.info(
      'Extracted ${result.length} fromJson blocks from $matchCount regex matches');

  // Enhanced fallback: If we didn't find many matches, try a more flexible approach
  if (result.length < 10) {
    logger.info('Low match count, trying enhanced fallback approach...');

    // Split content into lines and process more carefully
    final lines = content.split('\n');
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      // Look for fromJson function signatures with more flexible pattern
      final fromJsonMatch = RegExp(
              r'(\w+)\s+_\$(\w+)FromJson\s*\(\s*Map<String,\s*dynamic>\s+json\s*\)\s*=>')
          .firstMatch(line);

      if (fromJsonMatch != null) {
        final returnType = fromJsonMatch.group(1)!;
        final className = fromJsonMatch.group(2)!;

        // Skip if we already found this class
        if (result.containsKey(className)) continue;

        logger.info(
            'Fallback: Found fromJson function for class: $className (return type: $returnType)');

        // Find the constructor call - look for ClassName( pattern
        String constructorArgs = '';
        bool foundConstructor = false;
        int parenthesesDepth = 0;
        bool insideConstructor = false;

        // Search forward from current line to find the constructor
        for (int j = i; j < lines.length && j < i + 50; j++) {
          final currentLine = lines[j];

          if (!foundConstructor) {
            // Look for constructor pattern: ClassName(
            final constructorPattern = RegExp('\\b$className\\s*\\(');
            final constructorMatch = constructorPattern.firstMatch(currentLine);

            if (constructorMatch != null) {
              foundConstructor = true;
              insideConstructor = true;

              // Start collecting from after the opening parenthesis
              final startPos =
                  constructorMatch.end - 1; // Include the opening parenthesis
              final lineAfterConstructor = currentLine.substring(startPos + 1);

              // Process characters to track parentheses depth
              for (int k = 0; k < lineAfterConstructor.length; k++) {
                final char = lineAfterConstructor[k];
                if (char == '(') {
                  parenthesesDepth++;
                } else if (char == ')') {
                  parenthesesDepth--;
                  if (parenthesesDepth < 0) {
                    // Found the closing parenthesis of the constructor
                    insideConstructor = false;
                    break;
                  }
                }
                constructorArgs += char;
              }

              if (!insideConstructor) {
                break; // Constructor completed on same line
              }
            }
          } else if (insideConstructor) {
            // Continue collecting constructor arguments
            for (int k = 0; k < currentLine.length; k++) {
              final char = currentLine[k];
              if (char == '(') {
                parenthesesDepth++;
              } else if (char == ')') {
                parenthesesDepth--;
                if (parenthesesDepth < 0) {
                  // Found the closing parenthesis of the constructor
                  insideConstructor = false;
                  break;
                }
              }
              constructorArgs += char;
            }

            if (!insideConstructor) break; // Constructor completed
            constructorArgs += '\n'; // Add newline for multi-line constructors
          }

          // Stop if we hit a semicolon and we're not inside the constructor
          if (!insideConstructor && currentLine.contains(';')) {
            break;
          }
        }

        if (foundConstructor && constructorArgs.isNotEmpty) {
          result[className] = constructorArgs.trim();
          logger.info(
              'Fallback: Extracted constructor args for $className (${constructorArgs.length} chars)');
        } else {
          logger.warning('Fallback: Could not find constructor for $className');
        }
      }
    }
  }

  logger.info('Final result: Extracted ${result.length} fromJson blocks');
  return result;
}

/// Extracts field assignments from constructor arguments based on line endings.
/// Returns a map of field names to their assignment code.
Map<String, String> _extractFieldAssignments(String constructorArgs) {
  final logger = Logger('TypeScriptFromGDartGenerator');
  final fields = <String, String>{};

  if (constructorArgs.trim().isEmpty) {
    logger.info('Constructor args is empty, returning empty fields map');
    return fields;
  }

  logger
      .info('Processing constructor args (length: ${constructorArgs.length})');

  // Clean up the constructor args first - remove any trailing characters that aren't part of the structure
  String cleanedArgs = constructorArgs.trim();

  // Remove any trailing characters that might be artifacts
  if (cleanedArgs.endsWith(',')) {
    cleanedArgs = cleanedArgs.substring(0, cleanedArgs.length - 1);
  }

  // Split into logical field entries by looking for field patterns
  final fieldEntries = <String>[];
  final lines = cleanedArgs.split('\n');

  String currentEntry = '';
  int parenthesesDepth = 0;
  int squareBracketDepth = 0;
  int curlyBraceDepth = 0;
  bool inQuotes = false;
  String? quoteChar;

  for (final line in lines) {
    final trimmedLine = line.trim();
    if (trimmedLine.isEmpty) continue;

    // Process each character to track delimiters properly
    for (int i = 0; i < trimmedLine.length; i++) {
      final char = trimmedLine[i];
      final prevChar = i > 0 ? trimmedLine[i - 1] : '';

      // Handle quotes (only if not escaped)
      if ((char == '"' || char == "'") && prevChar != '\\') {
        if (!inQuotes) {
          inQuotes = true;
          quoteChar = char;
        } else if (char == quoteChar) {
          inQuotes = false;
          quoteChar = null;
        }
      }

      // Only track delimiters outside of quotes
      if (!inQuotes) {
        switch (char) {
          case '(':
            parenthesesDepth++;
            break;
          case ')':
            parenthesesDepth--;
            break;
          case '[':
            squareBracketDepth++;
            break;
          case ']':
            squareBracketDepth--;
            break;
          case '{':
            curlyBraceDepth++;
            break;
          case '}':
            curlyBraceDepth--;
            break;
        }
      }

      currentEntry += char;
    }

    // Check if we're at the end of a field entry
    final isBalanced = parenthesesDepth == 0 &&
        squareBracketDepth == 0 &&
        curlyBraceDepth == 0 &&
        !inQuotes;

    if (trimmedLine.endsWith(',') && isBalanced) {
      // Complete field entry found
      fieldEntries.add(currentEntry.trim());
      currentEntry = '';
    } else {
      // Continue building the current entry
      currentEntry += '\n';
    }
  }

  // Handle any remaining entry
  if (currentEntry.trim().isNotEmpty) {
    fieldEntries.add(currentEntry.trim());
  }

  // Parse each field entry
  for (final entry in fieldEntries) {
    final colonIndex = entry.indexOf(':');
    if (colonIndex == -1) continue;

    final fieldName = entry.substring(0, colonIndex).trim();
    String fieldValue = entry.substring(colonIndex + 1).trim();

    // Clean up field value - remove trailing comma and any stray characters
    if (fieldValue.endsWith(',')) {
      fieldValue = fieldValue.substring(0, fieldValue.length - 1).trim();
    }

    // Validate field name (should be a valid identifier)
    if (RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(fieldName)) {
      fields[fieldName] = fieldValue;
      logger.info('Extracted field: $fieldName');
    } else {
      logger.warning('Skipping invalid field name: "$fieldName"');
    }
  }

  logger.info('Extracted ${fields.length} fields: ${fields.keys.join(', ')}');
  return fields;
}

/// Enhanced field extraction that also looks for cascade assignments (..field = value)
Map<String, String> _extractAllFieldAssignments(
    String constructorArgs, String className) {
  final logger = Logger('TypeScriptFromGDartGenerator');
  final fields = <String, String>{};

  // First, extract fields from constructor arguments
  final constructorFields = _extractFieldAssignments(constructorArgs);
  fields.addAll(constructorFields);

  logger.info(
      'Extracted ${constructorFields.length} constructor fields for $className');

  // For cascade assignments, we need to look at the full content, not just constructor args
  // This will be handled separately in the main extraction function

  return fields;
}

/// Extracts cascade assignments from the full fromJson method content
Map<String, String> _extractCascadeAssignments(
    String content, String className) {
  final logger = Logger('TypeScriptFromGDartGenerator');
  final fields = <String, String>{};

  // Look for cascade assignments in the fromJson method
  // Updated regex to handle multiple cascade assignments properly
  final cascadeRegex = RegExp(r'\.\.(\w+)\s*=\s*([^;]+?)(?=\s*(?:\.\.|;))');
  final fromJsonPattern = RegExp(
      r'(\w+)\s+_\$' +
          className +
          r'FromJson\(Map<String, dynamic> json\)\s*=>\s*' +
          className +
          r'\([^)]*\)([\s\S]*?)(?=\n\w|\n\n|\Z)',
      multiLine: true);

  final fromJsonMatch = fromJsonPattern.firstMatch(content);
  if (fromJsonMatch != null) {
    final cascadeSection = fromJsonMatch.group(2) ?? '';
    logger.info(
        'Found cascade section for $className: ${cascadeSection.length} chars');

    for (final match in cascadeRegex.allMatches(cascadeSection)) {
      final fieldName = match.group(1)!;
      final fieldValue = match.group(2)!.trim();

      // Clean up the field value (remove trailing semicolons)
      String cleanValue = fieldValue;
      if (cleanValue.endsWith(';')) {
        cleanValue = cleanValue.substring(0, cleanValue.length - 1);
      }

      fields[fieldName] = cleanValue;
      logger.info('Extracted cascade field: $fieldName = $cleanValue');
    }
  } else {
    logger.warning('No fromJson method found for $className');

    // Try a simpler pattern to find cascade assignments anywhere in the content
    logger.info('Trying simpler cascade pattern search...');
    final simpleCascadeMatches = cascadeRegex.allMatches(content);
    for (final match in simpleCascadeMatches) {
      final fieldName = match.group(1)!;
      final fieldValue = match.group(2)!.trim();
      logger.info('Found cascade assignment: $fieldName = $fieldValue');
    }
  }

  logger
      .info('Total cascade fields extracted for $className: ${fields.length}');
  return fields;
}

/// Infers TypeScript type based on the assignment code string
String _inferTypeSimple(String assignmentCode, [String? fieldName]) {
  final code = assignmentCode.trim();

  // Check for nullability
  bool isNullable = code.contains(' == null') ||
      code.contains('?') && !code.contains('??') ||
      code.contains(' as ') && code.contains('?');

  final nullableSuffix = isNullable ? ' | null' : '';

  // 1. ObjectId converter detection - maps to string in TypeScript
  if (code.contains('NullableObjectIdConverter().fromJson(')) {
    return 'string | null';
  }
  if (code.contains('ObjectIdConverter().fromJson(')) {
    return 'string$nullableSuffix';
  }

  // 2. DateTime parsing detection - maps to string in TypeScript
  if (code.contains('DateTime.parse')) {
    return 'string$nullableSuffix';
  }

  // 3. List handling with proper element type inference
  if (code.contains('List<dynamic>') || code.contains(' as List')) {
    // Check for complex list transformations
    if (code.contains('.map') && code.contains('.toList()')) {
      // List of models using fromJson
      if (code.contains('fromJson')) {
        final modelNameRegex = RegExp(r'(\w+)\.fromJson');
        final match = modelNameRegex.firstMatch(code);
        if (match != null) {
          return '${match.group(1)}[]$nullableSuffix';
        }
      }

      // List of primitive types
      if (code.contains('as String')) {
        return 'string[]$nullableSuffix';
      } else if (code.contains('as int') ||
          code.contains('as num') ||
          code.contains('toDouble') ||
          code.contains('toInt')) {
        return 'number[]$nullableSuffix';
      } else if (code.contains('as bool')) {
        return 'boolean[]$nullableSuffix';
      }
    }

    // Simpler list handling
    if (code.contains('as List<String>')) {
      return 'string[]$nullableSuffix';
    } else if (code.contains('as List<int>') || code.contains('as List<num>')) {
      return 'number[]$nullableSuffix';
    } else if (code.contains('as List<bool>')) {
      return 'boolean[]$nullableSuffix';
    }

    // Default for lists when type can't be determined
    return 'any[]$nullableSuffix';
  }

  // 4. Set handling - maps to arrays in TypeScript
  if (code.contains('.toSet()') || code.contains('as Set')) {
    // Apply similar type inference as for lists
    if (code.contains('as String')) {
      return 'string[]$nullableSuffix';
    } else if (code.contains('as int') || code.contains('as num')) {
      return 'number[]$nullableSuffix';
    } else if (code.contains('as bool')) {
      return 'boolean[]$nullableSuffix';
    }

    // Default for sets
    return 'any[]$nullableSuffix';
  }

  // 5. Conditional expressions with model references
  // Check for conditional with fromJson in either branch (ternary operator)
  final conditionalRegex =
      RegExp(r'(.+)\s*==\s*null\s*\?\s*null\s*:\s*(.+)\.fromJson');
  final conditionalMatch = conditionalRegex.firstMatch(code);
  if (conditionalMatch != null) {
    final modelName = RegExp(r'(\w+)\.fromJson').firstMatch(code)?.group(1);
    if (modelName != null) {
      return '$modelName | null';
    }
  }

  // 6. Direct model references (standard fromJson pattern)
  final fromJsonRegex = RegExp(r'(\w+)\.fromJson');
  final fromJsonMatch = fromJsonRegex.firstMatch(code);
  if (fromJsonMatch != null) {
    return fromJsonMatch.group(1)! + nullableSuffix;
  }

  // 7. Map handling with key/value type inference
  if (code.contains('Map<String,')) {
    // Try to extract the value type
    final mapTypeRegex = RegExp(r'Map<String,\s*(\w+)>');
    final match = mapTypeRegex.firstMatch(code);
    if (match != null) {
      final valueType = match.group(1)!;

      // Convert Dart types to TypeScript
      String tsValueType;
      switch (valueType) {
        case 'int':
        case 'num':
        case 'double':
          tsValueType = 'number';
          break;
        case 'String':
          tsValueType = 'string';
          break;
        case 'bool':
          tsValueType = 'boolean';
          break;
        case 'dynamic':
          tsValueType = 'any';
          break;
        default:
          tsValueType = valueType; // Could be a custom type
      }

      return 'Record<string, $tsValueType>$nullableSuffix';
    }

    // Default for maps when value type can't be determined
    return 'Record<string, any>$nullableSuffix';
  }

  // 8. Enum references
  final enumMatch = RegExp(r'_\$(\w+)EnumMap').firstMatch(code);
  if (enumMatch != null) {
    return enumMatch.group(1)! + nullableSuffix;
  }

  // 9. Basic primitive types
  if (code.contains('as String')) {
    return 'string$nullableSuffix';
  } else if (code.contains('as int') ||
      code.contains('as num') ||
      code.contains('toDouble') ||
      code.contains('toInt')) {
    return 'number$nullableSuffix';
  } else if (code.contains('as bool')) {
    return 'boolean$nullableSuffix';
  } else if (code.contains('as dynamic')) {
    return 'any$nullableSuffix';
  }

  // Default fallback
  return 'any$nullableSuffix';
}

/// Public function to expose the private _inferTypeSimple for testing purposes
String inferTypeScriptTypeFromJson(String fieldAssignment, String fieldName) {
  // The fieldName is now used in the enhanced inference logic
  return _inferTypeSimple(fieldAssignment, fieldName);
}

/// Extracts fields from toJson methods to catch any missed fields
void _extractFieldsFromToJson(String content,
    Map<String, Map<String, String>> interfaces, Logger logger) {
  final toJsonRegex = RegExp(
      r'Map<String, dynamic> _\$(\w+)ToJson\(\w+ instance\) =>[\s\n]*\{([^}]+)');

  for (final match in toJsonRegex.allMatches(content)) {
    final className = match.group(1)!;
    final toJsonBody = match.group(2)!;

    logger.info('Analyzing toJson method for $className');

    if (!interfaces.containsKey(className)) {
      interfaces[className] = {};
      logger.info('Added missing model discovered from toJson: $className');
    }

    // Extract field mappings from toJson method
    final fieldMappings =
        RegExp("(['\"])([^'\"]*)(\\1)\\s*:\\s*instance\\.(\\w+)");
    for (final fieldMatch in fieldMappings.allMatches(toJsonBody)) {
      final jsonKeyName = fieldMatch.group(2)!;
      final fieldName = fieldMatch.group(4)!;

      // Only add if not already present
      if (!interfaces[className]!.containsKey(jsonKeyName)) {
        // Try to infer type from field name
        String inferredType = 'any';
        final lowerFieldName = fieldName.toLowerCase();

        if (lowerFieldName.contains('date') ||
            lowerFieldName.contains('time')) {
          inferredType = 'string';
        } else if (lowerFieldName.contains('count') ||
            lowerFieldName.contains('number') ||
            lowerFieldName.contains('amount') ||
            lowerFieldName.contains('qty') ||
            lowerFieldName.contains('price') ||
            lowerFieldName.contains('total')) {
          inferredType = 'number';
        } else if (lowerFieldName.startsWith('is') ||
            lowerFieldName.contains('flag') ||
            lowerFieldName.contains('enabled') ||
            lowerFieldName.contains('active')) {
          inferredType = 'boolean';
        }

        interfaces[className]![jsonKeyName] = inferredType;
        logger.info(
            '  - Added field from toJson: $jsonKeyName, Type: $inferredType');
      }
    }
  }
}
