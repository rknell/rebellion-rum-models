import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/sale_item.dart';

void main() {
  group('SaleItem', () {
    test('should serialize and deserialize correctly', () {
      final saleItem = SaleItem(
        description: 'Test Item',
        price: 29.99,
        itemId: 'ITEM123',
        qty: 2,
      );

      final json = saleItem.toJson();
      final decoded = SaleItem.fromJson(json);

      expect(decoded.description, equals(saleItem.description));
      expect(decoded.price, equals(saleItem.price));
      expect(decoded.itemId, equals(saleItem.itemId));
      expect(decoded.qty, equals(saleItem.qty));

      // Test the actual JSON structure
      expect(json['description'], equals('Test Item'));
      expect(json['price'], equals(29.99));
      expect(json['itemId'], equals('ITEM123'));
      expect(json['qty'], equals(2));
    });

    test('should handle various numeric values', () {
      final saleItem = SaleItem(
        description: 'Test Item',
        price: 0.99, // Test small price
        itemId: 'ITEM123',
        qty: 100, // Test large quantity
      );

      final json = saleItem.toJson();
      final decoded = SaleItem.fromJson(json);

      expect(decoded.price, equals(0.99));
      expect(decoded.qty, equals(100));
    });

    test('Invalid JSON handling', () {
      expect(
        () => SaleItem.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => SaleItem.fromJson({
          'description': 'Test',
          'price': 'not-a-number', // Wrong type (should be number)
          'itemId': 'TEST123',
          'qty': 1,
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => SaleItem.fromJson({
          'description': 'Test',
          'price': 29.99,
          'itemId': 'TEST123',
          'qty': 'not-a-number', // Wrong type (should be integer)
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => SaleItem.fromJson({
          'description': 'Test',
          'price': 29.99,
          // Missing required fields
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
