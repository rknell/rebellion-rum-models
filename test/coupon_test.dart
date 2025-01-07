import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/coupon.dart';

void main() {
  group('Coupon', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/coupons.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => Coupon.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => Coupon.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
