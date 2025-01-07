import 'dart:io';
import 'dart:convert';

/// Escapes a string for use in Dart string literals
String _escapeString(String str) {
  return str
      .replaceAll('\\', '\\\\')
      .replaceAll('\'', '\\\'')
      .replaceAll('\$', '\\\$')
      .replaceAll('\n', '\\n')
      .replaceAll('\r', '\\r')
      .replaceAll('\t', '\\t');
}

/// Generates test file content for a model
String _generateTestContent(
    String className, List<Map<String, dynamic>> sampleData) {
  final buffer = StringBuffer();

  // Add imports
  buffer.writeln("import 'dart:convert';");
  buffer.writeln("import 'package:test/test.dart';");
  buffer.writeln(
      "import 'package:rebellion_rum_models/src/models/${className.toLowerCase()}.dart';");
  buffer.writeln("import 'package:mongo_dart/mongo_dart.dart' show ObjectId;");
  buffer.writeln();

  // Begin test group
  buffer.writeln('void main() {');
  buffer.writeln('  group(\'$className\', () {');

  // Test JSON serialization for each sample
  for (var i = 0; i < sampleData.length; i++) {
    final sampleJson = _escapeString(jsonEncode(sampleData[i]));
    buffer.writeln('    test(\'Sample $i serialization\', () {');
    buffer.writeln(
        '      final data = jsonDecode(\'$sampleJson\') as Map<String, dynamic>;');
    buffer.writeln('      final model = $className.fromJson(data);');
    buffer.writeln('      final serialized = model.toJson();');
    buffer.writeln(
        '      expect(jsonEncode(serialized), equals(\'$sampleJson\'));');
    buffer.writeln('    });');
    buffer.writeln();
  }

  // Test invalid JSON
  buffer.writeln('    test(\'Invalid JSON handling\', () {');
  buffer.writeln('      expect(');
  buffer.writeln('        () => $className.fromJson({\'invalid\': \'data\'}),');
  buffer.writeln('        throwsA(isA<TypeError>()),');
  buffer.writeln('      );');
  buffer.writeln('    });');

  buffer.writeln('  });');
  buffer.writeln('}');

  return buffer.toString();
}

Future<void> main() async {
  final sampleDataDir = Directory('lib/src/sample_data');
  final testDir = Directory('test');

  if (!await testDir.exists()) {
    await testDir.create(recursive: true);
  }

  // Process each JSON file
  await for (final file in sampleDataDir.list()) {
    if (!file.path.endsWith('.json')) continue;

    final collectionName = file.uri.pathSegments.last.replaceAll('.json', '');
    var className = collectionName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join('');
    if (className.endsWith('s')) {
      className = className.substring(0, className.length - 1);
    }

    print('Generating tests for $className');

    final jsonContent = await File(file.path).readAsString();
    final sampleData =
        (jsonDecode(jsonContent) as List).cast<Map<String, dynamic>>();

    final testContent = _generateTestContent(className, sampleData);
    final testFile =
        File('${testDir.path}/${className.toLowerCase()}_test.dart');
    await testFile.writeAsString(testContent);

    print('Generated ${testFile.path}');
  }

  print('Test generation completed');
}
