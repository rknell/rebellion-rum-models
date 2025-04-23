import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_model.dart';

part 'startshipit_get_rates_response_model.g.dart';

/// Represents a response from the StartShipIt Get Rates API.
///
/// Contains a list of available shipping rates, success status,
/// and any errors that occurred during the request.
///
/// Example:
/// ```dart
/// final response = StartShipItGetRatesResponseModel(
///   rates: [rate1, rate2],
///   success: true,
///   errors: [],
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItGetRatesResponseModel {
  /// A list of available shipping rates (Rate Model)
  final List<StartShipItRateModel> rates;

  /// Determines whether the request was successfully submitted
  final bool success;

  const StartShipItGetRatesResponseModel(
      {required this.rates, required this.success});

  /// Creates an instance from a JSON object
  factory StartShipItGetRatesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItGetRatesResponseModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItGetRatesResponseModelToJson(this);
}
