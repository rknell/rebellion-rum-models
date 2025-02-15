// ignore_for_file: avoid_print

import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  // Define paths
  final modelsDir = Directory('lib/src/models');
  final outputFile = File('models_documentation.md');

  // Header for the markdown file
  final StringBuffer markdown = StringBuffer('''
# Models Documentation

This documentation is automatically generated from the model files.

''');

  try {
    // Get all .dart files in the models directory
    final files = await modelsDir
        .list(recursive: true)
        .where((entity) =>
            entity is File &&
            entity.path.endsWith('.dart') &&
            !entity.path.endsWith('.g.dart')) // Exclude generated files
        .cast<File>()
        .toList();

    // Sort files alphabetically
    files
        .sort((a, b) => path.basename(a.path).compareTo(path.basename(b.path)));

    // Process each file
    for (final file in files) {
      final fileName = path.basename(file.path);
      final content = await file.readAsString();

      // Add file header
      markdown.writeln('## ${fileName.replaceAll('.dart', '')}');
      markdown.writeln();

      // Add file path reference
      markdown.writeln('*File: ${file.path}*');
      markdown.writeln();

      // Add code block with content
      markdown.writeln('```dart');
      markdown.writeln(content);
      markdown.writeln('```');
      markdown.writeln();
    }

    // Write to output file
    await outputFile.writeAsString(markdown.toString());
    print('Documentation generated successfully at: ${outputFile.path}');
  } catch (e) {
    print('Error generating documentation: $e');
    exit(1);
  }
}
