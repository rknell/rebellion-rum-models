import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('SaleItemModel', () {
    test('should serialize and deserialize with all fields', () {
      final item = SaleItemModel(
        description: 'Premium Dark Rum 750ml',
        price: 49.99,
        itemId: 'PROD-001',
        qty: 2,
      );

      final json = item.toJson();
      final decoded = SaleItemModel.fromJson(json);

      expect(decoded.description, equals(item.description));
      expect(decoded.price, equals(item.price));
      expect(decoded.itemId, equals(item.itemId));
      expect(decoded.qty, equals(item.qty));
    });

    test('Invalid JSON handling', () {
      expect(
        () => SaleItemModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
