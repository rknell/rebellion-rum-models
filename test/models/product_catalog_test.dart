import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('catalog response round trips canonical product metadata', () {
    final product = ProductModel(
      id: ObjectId(),
      barcode: '3545899450941',
      name: 'Limoncello',
      volume: 700,
      abv: 0.30,
      revision: 4,
      updatedAt: DateTime.utc(2026, 8, 7),
    );
    final response = ProductCatalogResponseModel(
      products: [product],
      syncedAt: DateTime.utc(2026, 8, 7, 1),
      revision: 4,
    );

    final decoded = ProductCatalogResponseModel.fromJson(response.toJson());

    expect(decoded.products.single.id, product.id);
    expect(decoded.products.single.barcode, '3545899450941');
    expect(decoded.products.single.revision, 4);
    expect(decoded.products.single.updatedAt, DateTime.utc(2026, 8, 7));
  });

  test('legacy packaging runs remain readable without productId', () {
    final run = PackagingRunItemModel.fromJson({
      '_id': ObjectId().oid,
      'productBarcode': 'legacy-reference',
    });

    expect(run.productId, isNull);
    expect(run.productBarcode, 'legacy-reference');
  });
}
