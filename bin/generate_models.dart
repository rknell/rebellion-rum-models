import 'dart:io';
import 'dart:convert';

/// Determines the Dart type from a JSON value
String _getDartType(dynamic value) {
  if (value == null) return 'dynamic';
  if (value is bool) return 'bool';
  if (value is int) return 'int';
  if (value is double) return 'double';
  if (value is String) return 'String';
  if (value is List)
    return 'List<${_getDartType(value.isNotEmpty ? value.first : null)}>';
  if (value is Map) return 'Map<String, dynamic>';
  return 'dynamic';
}

/// Analyzes a JSON object to determine field types
Map<String, String> _analyzeFields(List<Map<String, dynamic>> documents) {
  final fields = <String, String>{};

  for (var doc in documents) {
    for (var entry in doc.entries) {
      final key = entry.key;
      final value = entry.value;

      if (!fields.containsKey(key)) {
        fields[key] = _getDartType(value);
      }
    }
  }

  return fields;
}

/// Generates a model class from field types
String _generateModelClass(String className, Map<String, String> fields) {
  final buffer = StringBuffer();

  // Add imports
  buffer.writeln("import 'package:json_annotation/json_annotation.dart';");
  buffer.writeln("import '../json_helpers.dart';");
  buffer.writeln();
  buffer.writeln("part '${className.toLowerCase()}.g.dart';");
  buffer.writeln();

  // Add class documentation
  buffer.writeln('/// $className model');
  buffer.writeln('/// Generated from MongoDB collection');
  buffer.writeln('@JsonSerializable()');
  buffer.writeln('class $className {');

  // Add fields
  for (var entry in fields.entries) {
    final key = entry.key;
    final type = entry.value;

    if (key == '_id') {
      buffer.writeln('  final String id;');
    } else {
      buffer.writeln('  final $type $key;');
    }
  }

  buffer.writeln();

  // Add constructor
  buffer.writeln('  $className({');
  for (var entry in fields.entries) {
    final key = entry.key;
    if (key == '_id') {
      buffer.writeln('    required this.id,');
    } else {
      buffer.writeln('    required this.$key,');
    }
  }
  buffer.writeln('  });');

  buffer.writeln();

  // Add fromJson/toJson
  buffer.writeln(
      '  factory $className.fromJson(Map<String, dynamic> json) => _\$${className}FromJson(json);');
  buffer.writeln(
      '  Map<String, dynamic> toJson() => _\$${className}ToJson(this);');

  buffer.writeln('}');

  return buffer.toString();
}

Future<void> main() async {
  final sampleDataDir = Directory('lib/src/sample_data');
  final modelsDir = Directory('lib/src/models');

  if (!modelsDir.existsSync()) {
    modelsDir.createSync(recursive: true);
  }

  for (var file in sampleDataDir.listSync()) {
    if (file is File && file.path.endsWith('.json')) {
      final className = _getClassName(file.path);
      final jsonContent = await file.readAsString();
      final List<Map<String, dynamic>> documents =
          (jsonDecode(jsonContent) as List)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      final fields = _analyzeFields(documents);
      final modelContent = _generateModelClass(className, fields);

      final modelFile =
          File('${modelsDir.path}/${className.toLowerCase()}.dart');
      await modelFile.writeAsString(modelContent);
    }
  }
}

String _getClassName(String filePath) {
  final fileName = filePath.split('/').last.split('.').first;
  return fileName
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join('');
}
