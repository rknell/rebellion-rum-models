import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  const address = StartShipItRateDestinationAddressModel(
    street: 'Test Street',
    suburb: 'Narangba',
    state: 'QLD',
    postCode: '4504',
  );
  test('negative bottle counts are rejected', () {
    expect(() => buildBottleShippingPackages(-1), throwsArgumentError);
  });
  test('plans conserve bottles and balance within the six-bottle capacity', () {
    for (var count = 1; count <= 100; count++) {
      final parcels = buildBottleShippingPackages(count);
      final bottles =
          parcels.map((p) => ((p.weight - 0.28) / 1.5).round()).toList();
      expect(bottles.reduce((a, b) => a + b), count);
      expect(bottles.every((n) => n >= 1 && n <= 6), isTrue);
      expect(bottles.first - bottles.last, lessThanOrEqualTo(1));
      expect(parcels.length, (count / 6).ceil());
    }
  });
  final splits = <int, List<int>>{
    0: [],
    1: [1],
    6: [6],
    7: [4, 3],
    9: [5, 4],
    10: [5, 5],
    11: [6, 5],
    12: [6, 6],
    13: [5, 4, 4],
    19: [5, 5, 5, 4],
  };
  for (final entry in splits.entries) {
    test('${entry.key} bottles have balanced parcel weights', () {
      final request = ShippingQuoteRequestModel(
          address: address, items: {'vodka': entry.key});
      final parcels = request.packages;
      expect(
          parcels.map((p) => p.weight), entry.value.map((n) => n * 1.5 + 0.28));
      for (final parcel in parcels) {
        expect(
            [parcel.length, parcel.width, parcel.height], [0.30, 0.23, 0.21]);
      }
    });
  }
  test('mixed products balance across the whole order', () {
    final request = ShippingQuoteRequestModel(
        address: address, items: {'vodka': 6, 'rum': 4});
    expect(request.packages.map((p) => p.weight), [7.78, 7.78]);
  });
}
