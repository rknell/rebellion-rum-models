import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/postcode.dart';

void main() {
  group('Postcode', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/postcodes.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should deserialize all sample records successfully', () {
      for (final data in sampleData) {
        expect(
          () => Postcode.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => Postcode.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
