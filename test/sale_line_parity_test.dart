import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test(
      'both channels snapshot supplied alcohol measurements and signed quantities',
      () {
    for (final (abv, qty, expected) in [
      (0.28, 3, 0.588),
      (0.37, 4, 1.036),
      (0.37, -4, -1.036)
    ]) {
      final line = SaleItemModel.fromProduct(
          product: ProductModel(barcode: 'spirit', volume: 700, abv: abv),
          price: 35,
          qty: qty);
      final restored = SaleItemModel.fromJson(line.toCommerceLedgerJson());
      expect(restored.isAlcohol, isTrue);
      expect(restored.hasAlcoholSnapshot, isTrue);
      expect(restored.totalLals, closeTo(expected, 1e-9));
      expect(restored.isMissingAlcoholSnapshot, isFalse);
      expect(line.toCommerceLedgerJson()['totalCents'], 3500 * qty);
    }
  });

  test('confirmed non-alcohol differs from unknown legacy data', () {
    final mixer = SaleItemModel.fromProduct(
        product: ProductModel(
            barcode: 'mixer',
            category: ProductCategory.softdrink,
            volume: 0,
            abv: 0),
        price: 3.5,
        qty: 2);
    expect(SaleItemModel.fromJson(mixer.toJson()).isAlcohol, isFalse);
    expect(mixer.isMissingAlcoholSnapshot, isFalse);
    final legacy = SaleItemModel(
        description: 'Unknown', price: 35, itemId: 'unknown', qty: 1);
    expect(legacy.isAlcohol, isNull);
    expect(legacy.isMissingAlcoholSnapshot, isTrue);
    for (final id in ['shipping', 'custom-sale-item:1']) {
      legacy.itemId = id;
      expect(legacy.isMissingAlcoholSnapshot, isFalse);
    }
  });

  test('known alcohol with invalid measurements cannot be sold', () {
    for (final volume in [0.0, double.infinity]) {
      expect(
          () => SaleItemModel.fromProduct(
              product: ProductModel(
                  barcode: 'vodka',
                  category: ProductCategory.vodka,
                  volume: volume,
                  abv: 0.37),
              price: 35,
              qty: 1),
          throwsArgumentError);
    }
  });

  test(
      'order roundtrip retains snapshots and sanitized input cannot replace them',
      () {
    final line = SaleItemModel.fromProduct(
        product: ProductModel(barcode: 'vodka', volume: 700, abv: 0.37),
        price: 35,
        qty: 4);
    OrderModel order(Map<String, int> items) => OrderModel(
        customerId: null,
        items: items,
        orderNumber: 'RUM1',
        paymentMethod: 'card');
    final original = order({'vodka': 4})..saleItems = [line];
    final restored = OrderModel.fromJson(original.toJson());
    expect(restored.saleItems!.single.totalLals, closeTo(1.036, 1e-9));
    restored.mergeSanitized(order({'vodka': 4}));
    expect(restored.saleItems, isNotNull);
    restored.mergeSanitized(order({'vodka': 2}));
    expect(restored.saleItems, isNull);
    expect(order({}).saleItems, isNull);
  });
}
