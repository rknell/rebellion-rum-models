import 'package:rebellion_rum_models/src/bottle_shipping_packages.dart';
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
  /// The destination address for the shipping quote
  final StartShipItRateDestinationAddressModel address;

  /// Map of item identifiers to quantities
  /// Key: Product/item identifier
  /// Value: Quantity of the item
  final Map<String, int> items;

  /// Calculates the total number of items by summing all quantities in the items map
  int get totalItems => items.values.fold(0, (sum, quantity) => sum + quantity);

  List<StartShipItRatePackageModel> get packages =>
      buildBottleShippingPackages(totalItems);

  StartShipItRateSenderAddressModel get sender =>
      StartShipItRateSenderAddressModel(
          building: "Unit 27",
          street: "3 Octal Street",
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
