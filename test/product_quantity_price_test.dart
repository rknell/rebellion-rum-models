import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('legacy products have no POS quantity deals', () {
    for (final json in <Map<String, dynamic>>[
      <String, dynamic>{},
      {'posQuantityPrices': null}
    ]) {
      expect(
          ProductModel.fromJson({'barcode': 'test', ...json}).posQuantityPrices,
          isEmpty);
    }
  });
  test('product deals and sale opt-in survive JSON round trips', () {
    final product = ProductModel(barcode: 'test', posQuantityPrices: [
      ProductQuantityPrice(minimumQuantity: 4, unitPrice: 6.5)
    ]);
    final restored = ProductModel.fromJson(product.toJson());
    expect(restored.posQuantityPrices.single.toJson(),
        {'minimumQuantity': 4, 'unitPrice': 6.5});
    final item = SaleItemModel(
        description: 'test',
        price: 6.5,
        itemId: 'test',
        qty: 4,
        automaticQuantityPricing: true);
    expect(
        SaleItemModel.fromJson(item.toJson()).automaticQuantityPricing, isTrue);
    expect(
        SaleItemModel.fromJson({
          'description': 'legacy',
          'price': 8,
          'itemId': 'test',
          'qty': 1
        }).automaticQuantityPricing,
        isFalse);
  });
  test('reject malformed persisted deals', () {
    for (final value in [
      1,
      <String, dynamic>{},
      'bad',
      [null],
      [1]
    ]) {
      expect(
          () => ProductModel.fromJson(
              {'barcode': 'test', 'posQuantityPrices': value}),
          throwsFormatException);
    }
    for (final quantity in [null, '4', 4.5, 1, -2]) {
      expect(
          () => ProductQuantityPrice.fromJson(
              {'minimumQuantity': quantity, 'unitPrice': 6.5}),
          throwsFormatException);
    }
    for (final price in [null, '6.5', -1, double.nan, double.infinity]) {
      expect(
          () => ProductQuantityPrice.fromJson(
              {'minimumQuantity': 4, 'unitPrice': price}),
          throwsFormatException);
    }
  });
}
