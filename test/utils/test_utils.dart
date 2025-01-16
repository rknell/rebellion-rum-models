import 'dart:io';
import 'package:path/path.dart' as path;

/// Loads a test resource file as a string
Future<String> loadTestResourceAsString(String resourcePath) async {
  final testDir = path.dirname(Platform.script.toFilePath());
  final filePath = path.join(testDir, '..', resourcePath);
  return File(filePath).readAsString();
}
