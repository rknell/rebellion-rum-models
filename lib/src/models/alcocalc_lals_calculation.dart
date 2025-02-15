import "package:alcocalc/alcocalc.dart";
import 'package:json_annotation/json_annotation.dart';

part 'alcocalc_lals_calculation.g.dart';

/// A model for calculating litres of alcohol (LALs) using the alcocalc package.
@JsonSerializable(explicitToJson: true)
class AlcocalcLalsCalculation {
  /// Creates a new instance of [AlcocalcLalsCalculation].
  AlcocalcLalsCalculation({
    required this.weight,
    required this.abv,
    required this.temperature,
  }) : lals = Alcocalc.litresOfAlcoholCalculation(
          weight: weight,
          abv: abv,
          temperature: temperature,
        );

  /// Weight in kilograms
  final double weight;

  /// Alcohol by volume percentage
  final double abv;

  /// Temperature in celsius
  final double temperature;

  /// Litres of alcohol calculated from the given parameters
  final double lals;

  /// Creates an instance from a JSON object
  factory AlcocalcLalsCalculation.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcLalsCalculationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$AlcocalcLalsCalculationToJson(this);
}
