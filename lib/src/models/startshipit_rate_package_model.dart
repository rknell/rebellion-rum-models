import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_package_model.g.dart';

/// Represents a package for StartShipIt rate calculations.
///
/// Contains all required package dimensions and weight for shipping rate calculations,
/// including weight, height, width, and length.
///
/// Example:
/// ```dart
/// final package = StartShipItRatePackageModel(
///   weight: 1.5,
///   height: 0.3,
///   width: 0.25,
///   length: 0.4,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRatePackageModel {
  /// Physical weight of the parcel in kilograms (kg)
  final double weight;

  /// Height of the parcel in meters (m)
  final double? height;

  /// Width of the parcel in meters (m)
  final double? width;

  /// Length of the parcel in meters (m)
  final double? length;

  const StartShipItRatePackageModel({
    required this.weight,
    this.height,
    this.width,
    this.length,
  });

  /// Creates an instance from a JSON object
  factory StartShipItRatePackageModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItRatePackageModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItRatePackageModelToJson(this);
}
