import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/product_item.dart';

void main() {
  group('ProductItem', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/productItems.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should successfully deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => ProductItem.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => ProductItem.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
