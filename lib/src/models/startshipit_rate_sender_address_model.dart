import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_sender_address_model.g.dart';

/// Represents a sender address for StartShipIt rate calculations.
///
/// Contains all required address components for shipping rate calculations,
/// including street, suburb, city, state, post code, and country code.
///
/// Example:
/// ```dart
/// final senderAddress = StartShipItRateSenderAddressModel(
///   street: '123 Main St',
///   suburb: 'Richmond',
///   city: 'Melbourne',
///   state: 'VIC',
///   postCode: '3121',
///   countryCode: 'AU',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateSenderAddressModel {
  /// Street number and name of the sender address
  final String street;

  /// Suburb of the sender address
  final String suburb;

  /// City of the sender address
  final String city;

  /// State, regional, provincial or county name of the sender address
  final String state;

  /// Postal or zip code of the sender address
  final String postCode;

  /// The country code of the sender address
  final String countryCode;

  const StartShipItRateSenderAddressModel({
    required this.street,
    required this.suburb,
    required this.state,
    required this.postCode,
    required this.countryCode,
  }) : city = suburb;

  /// Creates an instance from a JSON object
  factory StartShipItRateSenderAddressModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItRateSenderAddressModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItRateSenderAddressModelToJson(this);
}
