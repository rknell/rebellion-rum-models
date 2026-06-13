import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_destination_address_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_package_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_sender_address_model.dart';

part 'shipping_quote_request_model.g.dart';

/// Represents a request for shipping quotes.
///
/// This model wraps a destination address and a map of items with their quantities.
/// It's used to request shipping rate quotes for a specific address and set of items.
///
/// Example:
/// ```dart
/// final request = ShippingQuoteRequestModel(
///   address: <StartShipItRateDestinationAddressModel>,
///   items: {'product-123': 2, 'product-456': 1},
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingQuoteRequestModel {
  static const double _bottleWeightKg = 1.5;
  static const double _packagingMaterialsWeightKg = 0.28;
  static const double _packageLengthM = 0.30;
  static const double _packageWidthM = 0.23;
  static const double _packageHeightM = 0.21;
  static const int _maxItemsPerPackage = 6;

  /// The destination address for the shipping quote
  final StartShipItRateDestinationAddressModel address;

  /// Map of item identifiers to quantities
  /// Key: Product/item identifier
  /// Value: Quantity of the item
  final Map<String, int> items;

  /// Calculates the total number of items by summing all quantities in the items map
  int get totalItems => items.values.fold(0, (sum, quantity) => sum + quantity);

  List<StartShipItRatePackageModel> get packages {
    // Calculate how many packages we need based on the total items
    // Each package can hold up to 6 items
    final int totalItems = this.totalItems;
    final int packagesNeeded = (totalItems / _maxItemsPerPackage).ceil();

    // Create the list of packages
    final List<StartShipItRatePackageModel> result = [];

    int remainingItems = totalItems;

    // Create each package with the appropriate number of items
    for (int i = 0; i < packagesNeeded; i++) {
      // For each package, determine how many items it will contain
      // (up to 6 items per package)
      final int itemsInPackage = remainingItems >= _maxItemsPerPackage
          ? _maxItemsPerPackage
          : remainingItems;

      result.add(
        StartShipItRatePackageModel(
          weight:
              (itemsInPackage * _bottleWeightKg) + _packagingMaterialsWeightKg,
          length: _packageLengthM,
          width: _packageWidthM,
          height: _packageHeightM,
        ),
      );

      remainingItems -= itemsInPackage;
    }

    return result;
  }

  StartShipItRateSenderAddressModel get sender =>
      StartShipItRateSenderAddressModel(
          street: "Unit 27/3 Octal St",
          suburb: "Yatala",
          state: "QLD",
          postCode: "4207",
          countryCode: "AU");

  const ShippingQuoteRequestModel({
    required this.address,
    required this.items,
  });

  /// Creates an instance from a JSON object
  factory ShippingQuoteRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingQuoteRequestModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ShippingQuoteRequestModelToJson(this);
}
