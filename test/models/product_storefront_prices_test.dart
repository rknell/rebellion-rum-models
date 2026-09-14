import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('legacy products have no storefront retail overrides', () {
    final product = ProductModel.fromJson({'barcode': 'legacy', 'price': 45});
    expect(product.storefrontRetailPrices, isEmpty);
    expect(product.websitePrice, 45);
  });

  test('storefront retail overrides survive catalogue serialization', () {
    final product = ProductModel.fromJson({
      'barcode': '9369999944360',
      'websitePrice': 45,
      'wholesalePrice': 45,
      'storefrontRetailPrices': {'fuckhead': 60},
    });
    final restored = ProductModel.fromJson(product.toJson());
    expect(restored.storefrontRetailPrices, {'fuckhead': 60.0});
    expect(restored.websitePrice, 45);
    expect(restored.wholesalePrice, 45);
  });
}
