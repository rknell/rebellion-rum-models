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

    test('should serialize and deserialize correctly', () {
      final postcode = Postcode(
        id: 'test-id',
        postcode: '3000',
        locality: 'MELBOURNE',
        state: 'VIC',
        combined: 'MELBOURNE 3000 VIC',
      );

      final json = postcode.toJson();
      final decoded = Postcode.fromJson(json);

      expect(decoded.id, equals(postcode.id));
      expect(decoded.postcode, equals(postcode.postcode));
      expect(decoded.locality, equals(postcode.locality));
      expect(decoded.state, equals(postcode.state));
      expect(decoded.combined, equals(postcode.combined));

      // Test the actual JSON structure
      expect(json['_id'], equals('test-id'));
      expect(json['postcode'], equals('3000'));
      expect(json['locality'], equals('MELBOURNE'));
      expect(json['state'], equals('VIC'));
      expect(json['combined'], equals('MELBOURNE 3000 VIC'));
    });

    test('should handle sample data serialization', () {
      for (final data in sampleData) {
        final postcode = Postcode.fromJson(data);
        final serialized = postcode.toJson();

        // Verify all fields are correctly serialized
        expect(serialized['_id'], equals(data['_id']));
        expect(serialized['postcode'], equals(data['postcode']));
        expect(serialized['locality'], equals(data['locality']));
        expect(serialized['state'], equals(data['state']));
        expect(serialized['combined'], equals(data['combined']));
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => Postcode.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Postcode.fromJson({
          '_id': 'test',
          'postcode': 123, // Wrong type (should be string)
          'locality': 'TEST',
          'state': 'VIC',
          'combined': 'TEST',
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Postcode.fromJson({
          '_id': 'test',
          'postcode': '3000',
          // Missing required fields
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
