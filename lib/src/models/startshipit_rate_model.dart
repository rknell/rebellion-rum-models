import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_model.g.dart';

/// Represents a shipping rate from StartShipIt.
///
/// Contains information about the carrier service, including service name,
/// service code, and total price.
///
/// Example:
/// ```dart
/// final rate = StartShipItRateModel(
///   serviceName: 'Express Post',
///   serviceCode: 'AUS_EXPRESS',
///   totalPrice: 15.50,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateModel {
  /// Description of the carrier service
  final String serviceName;

  /// Carrier service/product code
  final String serviceCode;

  /// Price of service
  final double totalPrice;

  const StartShipItRateModel({
    required this.serviceName,
    required this.serviceCode,
    required this.totalPrice,
  });

  /// Creates an instance from a JSON object
  factory StartShipItRateModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItRateModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItRateModelToJson(this);
}
