import 'package:rebellion_rum_models/src/models/startshipit_rate_package_model.dart';

/// Plans the minimum number of standard cartons, with bottle counts differing
/// by at most one. Larger cartons come first when the split is uneven.
///
/// Uses the existing six-bottle capacity, 1.5 kg per bottle, 280 g packaging
/// allowance and 30 x 23 x 21 cm carton for quotes and shipment creation alike.
/// This only plans new shipments; it does not change existing shipping labels.
List<StartShipItRatePackageModel> buildBottleShippingPackages(int bottleCount) {
  if (bottleCount < 0) {
    throw ArgumentError.value(
        bottleCount, 'bottleCount', 'Must be non-negative');
  }
  if (bottleCount == 0) return [];

  const capacity = 6;
  final parcelCount = (bottleCount + capacity - 1) ~/ capacity;
  final bottlesPerParcel = bottleCount ~/ parcelCount;
  final extraBottles = bottleCount % parcelCount;
  return List.generate(parcelCount, (index) {
    final bottles = bottlesPerParcel + (index < extraBottles ? 1 : 0);
    return StartShipItRatePackageModel(
      weight: bottles * 1.5 + 0.28,
      length: 0.30,
      width: 0.23,
      height: 0.21,
    );
  });
}
