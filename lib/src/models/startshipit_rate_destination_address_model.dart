import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_destination_address_model.g.dart';

/// Represents a destination address for StartShipIt rate calculations.
///
/// Contains all required address components for shipping rate calculations,
/// including street, suburb, city, state, post code, and country code.
///
/// Example:
/// ```dart
/// final destinationAddress = StartShipItRateDestinationAddressModel(
///   street: '123 Main St',
///   suburb: 'Richmond',
///   city: 'Melbourne',
///   state: 'VIC',
///   postCode: '3121',
///   countryCode: 'AU',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateDestinationAddressModel {
  /// Street number and name of the delivery address
  final String street;

  /// Suburb of the delivery address
  final String suburb;

  /// City of the delivery address
  final String city;

  /// State, regional, provincial or county name of the delivery address
  final String state;

  /// Postal or zip code of the delivery address
  final String postCode;

  /// The country code of the delivery address
  final String countryCode;

  const StartShipItRateDestinationAddressModel({
    required this.street,
    required this.suburb,
    required this.state,
    required this.postCode,
    this.countryCode = 'AU',
  }) : city = suburb;

  /// Creates an instance from a JSON object
  factory StartShipItRateDestinationAddressModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItRateDestinationAddressModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItRateDestinationAddressModelToJson(this);
}
