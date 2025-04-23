import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_destination_address_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_package_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_sender_address_model.dart';

part 'startshipit_get_rates_request_model.g.dart';

/// Represents a request to get shipping rates from StartShipIt.
///
/// Contains sender and destination addresses, package information,
/// and currency code.
///
/// Example:
/// ```dart
/// final request = StartShipItGetRatesRequestModel(
///   destination: destinationAddress,
///   packages: [package1, package2],
///   currency: 'AUD',
///   sender: senderAddress,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class StartShipItGetRatesRequestModel {
  /// Sender address details (Rate Sender Address Model)
  /// If not provided, Pickup Address details from the Settings are used
  final StartShipItRateSenderAddressModel? sender;

  /// Shipping address details (Rate Destination Address Model)
  final StartShipItRateDestinationAddressModel destination;

  /// A list of packages with weight and dimensions (Rate Package Model)
  final List<StartShipItRatePackageModel> packages;

  /// Currency code for the order value (max length: 3) e.g. AUD
  final String currency;

  const StartShipItGetRatesRequestModel({
    this.sender,
    required this.destination,
    required this.packages,
    this.currency = "AUD",
  });

  /// Creates an instance from a JSON object
  factory StartShipItGetRatesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItGetRatesRequestModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItGetRatesRequestModelToJson(this);
}
