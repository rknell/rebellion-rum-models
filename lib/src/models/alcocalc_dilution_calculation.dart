import 'package:alcocalc/alcocalc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alcocalc_dilution_calculation.g.dart';

/// A model for recording dilution calculations using the alcocalc package.
/// This model stores the input parameters and calculated results for audit purposes.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionCalculation {
  /// Creates a new instance of [AlcocalcDilutionCalculation].
  factory AlcocalcDilutionCalculation({
    required double startingWeight,
    required double startingAbv,
    required double targetAbv,
    List<SugarAddition> sugars = const [],
    double temperature = 20.0,
  }) {
    // Validate inputs
    if (startingAbv <= targetAbv) {
      throw ArgumentError('Starting ABV must be greater than target ABV');
    }
    if (startingAbv <= 0 || startingAbv > 100) {
      throw ArgumentError('Starting ABV must be between 0 and 100');
    }
    if (targetAbv <= 0 || targetAbv > 100) {
      throw ArgumentError('Target ABV must be between 0 and 100');
    }
    if (temperature < -20 || temperature > 40) {
      throw ArgumentError('Temperature must be between -20°C and 40°C');
    }

    // Calculate dilution once
    final result = dilution(
      startingWeight: startingWeight,
      startingABV: startingAbv,
      startingTemperature: temperature,
      sugars: sugars.map((s) => s.toSugars()).toList(),
      targetABV: targetAbv,
    );

    // Create instance with all values
    return AlcocalcDilutionCalculation._(
      startingWeight: startingWeight,
      startingAbv: startingAbv,
      targetAbv: targetAbv,
      temperature: temperature,
      sugars: sugars,
      date: DateTime.now(),
      waterToAdd: result.additionalWaterLitres,
      weightAfterWater: result.targetWeightAfterWater,
      finalVolume: result.targetVolume,
      lals: result.lals,
      expectedBottles: result.expectedBottles,
      calculatedAbv: result.calculatedABV,
      acceptableAbvLow: result.acceptableABVLow,
      acceptableAbvHigh: result.acceptableABVHigh,
      sugarResults: result.sugarResults
          .map((sugar) => SugarResult(
                name: sugar.name,
                weight: sugar.weight,
              ))
          .toList(),
    );
  }

  /// Private constructor for creating an instance with pre-calculated values
  const AlcocalcDilutionCalculation._({
    required this.startingWeight,
    required this.startingAbv,
    required this.targetAbv,
    required this.temperature,
    required this.sugars,
    required this.date,
    required this.waterToAdd,
    required this.weightAfterWater,
    required this.finalVolume,
    required this.lals,
    required this.expectedBottles,
    required this.calculatedAbv,
    required this.acceptableAbvLow,
    required this.acceptableAbvHigh,
    required this.sugarResults,
  });

  /// Starting weight in kilograms
  final double startingWeight;

  /// Starting alcohol by volume percentage
  final double startingAbv;

  /// Target alcohol by volume percentage
  final double targetAbv;

  /// Temperature in celsius
  final double temperature;

  /// Optional list of sugars to add (for liqueurs)
  final List<SugarAddition> sugars;

  /// Date and time of calculation
  final DateTime date;

  /// Amount of water to add in litres to reach target ABV
  final double waterToAdd;

  /// Target weight after adding water (before sugar additions)
  final double weightAfterWater;

  /// Final volume after dilution in litres
  final double finalVolume;

  /// Total litres of absolute alcohol (LALs)
  final double lals;

  /// Expected number of 700ml bottles
  final double expectedBottles;

  /// Calculated ABV after all additions
  final double calculatedAbv;

  /// Minimum acceptable ABV for quality control
  final double acceptableAbvLow;

  /// Maximum acceptable ABV for quality control
  final double acceptableAbvHigh;

  /// List of sugar additions with calculated weights
  final List<SugarResult> sugarResults;

  /// Creates an instance from a JSON object
  factory AlcocalcDilutionCalculation.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionCalculationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$AlcocalcDilutionCalculationToJson(this);
}

/// Represents a sugar addition in the dilution calculation
@JsonSerializable(explicitToJson: true)
class SugarAddition {
  /// Name of the sugar (e.g., "White Sugar", "Honey", etc.)
  final String name;

  /// Specific gravity of the sugar
  final double specificGravity;

  /// Percentage of sugar to add (as a decimal, e.g., 0.1 for 10%)
  final double percentage;

  /// Creates a new instance of [SugarAddition]
  SugarAddition({
    required this.name,
    required this.specificGravity,
    required this.percentage,
  }) : assert(percentage < 1, "Percentage must be a decimal");

  /// Converts this instance to a Sugars object for calculation
  Sugars toSugars() => Sugars(
        name: name,
        specificGravity: specificGravity,
        percentage: percentage,
      );

  /// Creates an instance from a JSON object
  factory SugarAddition.fromJson(Map<String, dynamic> json) =>
      _$SugarAdditionFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$SugarAdditionToJson(this);
}

/// Represents the result of a sugar addition calculation
@JsonSerializable(explicitToJson: true)
class SugarResult {
  /// Name of the sugar
  final String name;

  /// Weight of sugar to add in kilograms
  final double weight;

  /// Creates a new instance of [SugarResult]
  SugarResult({
    required this.name,
    required this.weight,
  });

  /// Creates an instance from a JSON object
  factory SugarResult.fromJson(Map<String, dynamic> json) =>
      _$SugarResultFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$SugarResultToJson(this);
}
