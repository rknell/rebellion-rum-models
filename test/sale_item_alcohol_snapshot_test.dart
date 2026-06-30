import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('old sale items without alcohol snapshots still deserialize', () {
    final item = SaleItemModel.fromJson({
      'description': 'Legacy sale line',
      'price': 74.0,
      'itemId': 'legacy-rum',
      'qty': 2,
    });

    expect(item.unitVolumeMl, isNull);
    expect(item.unitAbv, isNull);
    expect(item.lalPerUnit, isNull);
    expect(item.totalLals, isNull);
    expect(item.hasAlcoholSnapshot, isFalse);
  });

  test('sale item alcohol snapshots serialize and refresh totals', () {
    final item = SaleItemModel(
      description: '700ml 40% rum',
      price: 79.0,
      itemId: 'rum-700',
      qty: 2,
      unitVolumeMl: 700,
      unitAbv: 0.4,
      lalPerUnit: 0.28,
      totalLals: 0.56,
    );

    final json = item.toJson();
    expect(json['unitVolumeMl'], 700);
    expect(json['unitAbv'], 0.4);
    expect(json['lalPerUnit'], 0.28);
    expect(json['totalLals'], 0.56);

    item.qty = 3;
    item.refreshAlcoholTotals();

    expect(item.totalLals, closeTo(0.84, 0.000001));
  });

  test('alcohol snapshot helper uses volume millilitres and decimal ABV', () {
    final snapshot = alcoholSnapshotForSaleLine(
      volumeMl: 700,
      abv: 0.4,
      quantity: 6,
    );

    expect(snapshot, isNotNull);
    expect(snapshot!.lalPerUnit, closeTo(0.28, 0.000001));
    expect(snapshot.totalLals, closeTo(1.68, 0.000001));
  });
}
