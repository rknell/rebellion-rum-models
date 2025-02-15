// ignore_for_file: strict_raw_type, comment_references

import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';

/// Loads JSON test data from a resource file.
///
/// [resourcePath] should be relative to the test directory
/// e.g. 'resources/sales.json'
List<Map<String, dynamic>> loadJsonData(String resourcePath) {
  final file = File('test/$resourcePath');
  final jsonStr = file.readAsStringSync();
  final List<dynamic> rawJson = jsonDecode(jsonStr);
  return rawJson.cast<Map<String, dynamic>>();
}

/// Tests that a JsonSerializable model correctly preserves all fields during serialization.
void validateJsonSerialization<T>(
  T instance,
  T Function(Map<String, dynamic>) fromJson,
) {
  // Convert to JSON
  final json = (instance as dynamic).toJson() as Map<String, dynamic>;

  // Convert back to object
  final deserializedInstance = fromJson(json);

  // Convert deserialized instance back to JSON for comparison
  final deserializedJson =
      (deserializedInstance as dynamic).toJson() as Map<String, dynamic>;

  // Check that all original keys exist in the deserialized JSON
  for (final key in json.keys) {
    expect(deserializedJson.containsKey(key), isTrue,
        reason: 'Key "$key" is missing after deserialization');

    // Compare values
    if (json[key] is Map) {
      expect(deserializedJson[key], isA<Map>());
    } else if (json[key] is List) {
      expect(deserializedJson[key], isA<List>());
    } else {
      expect(deserializedJson[key], json[key],
          reason: 'Value for key "$key" does not match after deserialization');
    }
  }

  // Check that no extra keys were added
  expect(deserializedJson.keys.length, json.keys.length,
      reason: 'Number of keys changed during serialization');
}

/// Creates a standard set of JSON serialization tests for a model.
///
/// [resourcePath] should be relative to the test directory
/// [fromJson] is the factory constructor for creating model instances
/// [getId] is a function to extract an ID from the JSON for error reporting
void createJsonSerializationTests<T>({
  required String resourcePath,
  required T Function(Map<String, dynamic>) fromJson,
}) {
  group('$T JSON Serialization Tests', () {
    final jsonData = loadJsonData(resourcePath);

    test('Should be able to parse all sample $T', () {
      for (final json in jsonData) {
        expect(
          () => fromJson(json),
          returnsNormally,
          reason: 'Failed to parse ${T.toString()} with ID: ${json['_id']}',
        );
      }
    });

    test('All $T should preserve fields during serialization', () {
      for (final json in jsonData) {
        final instance = fromJson(json);
        validateJsonSerialization(instance, fromJson);
      }
    });
  });
}
