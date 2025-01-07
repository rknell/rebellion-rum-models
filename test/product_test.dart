import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/product.dart';

void main() {
  group('ProductModel', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/products.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => ProductModel.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('should serialize and deserialize correctly', () {
      for (final data in sampleData) {
        final product = ProductModel.fromJson(data);
        final serialized = product.toJson();
        final deserialized = ProductModel.fromJson(serialized);

        expect(deserialized.id, equals(product.id));
        expect(deserialized.barcode, equals(product.barcode));
        expect(deserialized.description, equals(product.description));
        expect(deserialized.price, equals(product.price));
        expect(deserialized.stock, equals(product.stock));
        expect(deserialized.category, equals(product.category));
        expect(
            deserialized.isAvailableOnline, equals(product.isAvailableOnline));
        expect(deserialized.name, equals(product.name));
        expect(deserialized.images, equals(product.images));
        expect(deserialized.longDescription, equals(product.longDescription));
        expect(deserialized.shortDescription, equals(product.shortDescription));
        expect(deserialized.volume, equals(product.volume));
        expect(deserialized.weight, equals(product.weight));
        expect(deserialized.abv, equals(product.abv));
        expect(deserialized.shortcut, equals(product.shortcut));
        expect(deserialized.enabled, equals(product.enabled));
      }
    });

    test('should handle all field combinations', () {
      final productWithAllFields = ProductModel(
        id: 'test-id',
        barcode: 'TEST123',
        description: 'Test product',
        price: 100.0,
        stock: 10,
        category: 'test',
        isAvailableOnline: true,
        name: 'Test Name',
        images: ['image1.jpg', 'image2.jpg'],
        longDescription: 'Long description',
        shortDescription: 'Short description',
        volume: 750,
        weight: 1.5,
        abv: 40.0,
        shortcut: 'test-shortcut',
        enabled: true,
      );

      final productWithMinimalFields = ProductModel(
        id: 'test-id',
        barcode: 'TEST123',
        description: 'Test product',
        price: 100.0,
        stock: 10,
        category: 'test',
      );

      // Test all fields present
      final allFieldsJson = productWithAllFields.toJson();
      expect(allFieldsJson['_id'], equals('test-id'));
      expect(allFieldsJson['barcode'], equals('TEST123'));
      expect(allFieldsJson['description'], equals('Test product'));
      expect(allFieldsJson['price'], equals(100.0));
      expect(allFieldsJson['stock'], equals(10));
      expect(allFieldsJson['category'], equals('test'));
      expect(allFieldsJson['isAvailableOnline'], isTrue);
      expect(allFieldsJson['name'], equals('Test Name'));
      expect(allFieldsJson['images'], equals(['image1.jpg', 'image2.jpg']));
      expect(allFieldsJson['longDescription'], equals('Long description'));
      expect(allFieldsJson['shortDescription'], equals('Short description'));
      expect(allFieldsJson['volume'], equals(750));
      expect(allFieldsJson['weight'], equals(1.5));
      expect(allFieldsJson['abv'], equals(40.0));
      expect(allFieldsJson['shortcut'], equals('test-shortcut'));
      expect(allFieldsJson['enabled'], isTrue);

      // Test minimal fields
      final minimalFieldsJson = productWithMinimalFields.toJson();
      expect(minimalFieldsJson['isAvailableOnline'], isFalse); // Default value
      expect(minimalFieldsJson['name'], isNull);
      expect(minimalFieldsJson['images'], isEmpty);
      expect(minimalFieldsJson['longDescription'], isNull);
      expect(minimalFieldsJson['shortDescription'], isNull);
      expect(minimalFieldsJson['volume'], isNull);
      expect(minimalFieldsJson['weight'], isNull);
      expect(minimalFieldsJson['abv'], isNull);
      expect(minimalFieldsJson['shortcut'], isNull);
      expect(minimalFieldsJson['enabled'], isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => ProductModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => ProductModel.fromJson({
          '_id': 'test',
          'barcode': 'TEST',
          'description': 'Test',
          'price': 'not-a-number',
          'stock': 'not-a-number',
          'category': 'test',
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
