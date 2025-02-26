import 'package:alcocalc/alcocalc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/product.dart';

part 'alcocalc_dilution_calculation.g.dart';

/// Represents a sugar to be added to a product recipe
@JsonSerializable(explicitToJson: true)
class AlcocalcSugar {
  /// Name of the sugar (e.g., "White Sugar", "Honey", etc.)
  final String name;

  /// Weight of sugar in kilograms
  final double weight;

  /// Brix measurement of the sugar
  final double brix;

  /// Creates a new instance of [AlcocalcSugar]
  AlcocalcSugar({
    required this.name,
    required this.weight,
    required this.brix,
  });

  /// Creates an instance from a JSON object
  factory AlcocalcSugar.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcSugarFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$AlcocalcSugarToJson(this);
}

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

  /// Creates a new instance of [AlcocalcDilutionCalculation] from a product recipe.
  ///
  /// Takes the starting weight, starting ABV, and a product recipe which provides
  /// the target ABV and any sugar additions required for the recipe. This factory
  /// simplifies creating dilution calculations that adhere to standardized recipes.
  factory AlcocalcDilutionCalculation.fromRecipe({
    required double startingWeight,
    required double startingAbv,
    required ProductRecipe recipe,
    double temperature = 20.0,
  }) {
    return AlcocalcDilutionCalculation(
      startingWeight: startingWeight,
      startingAbv: startingAbv,
      targetAbv: recipe.targetAbv,
      sugars: recipe.sugars,
      temperature: temperature,
    );
  }

  /// Private constructor for creating an instance with pre-calculated values
  AlcocalcDilutionCalculation._({
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
  }) {
    // Calculate the final weight (after water and sugar)
    _finalWeight = weightAfterWater +
        sugarResults.fold(0.0, (sum, sugar) => sum + sugar.weight);
  }

  // Final weight after all additions (water + sugar)
  double _finalWeight = 0.0;

  /// The final weight after adding water and all sugars
  /// This is the total weight including the starting liquid, added water, and any sugar additions
  double get finalWeight => _finalWeight;

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

  /// Specific gravity of the sugar (single source of truth)
  final double specificGravity;

  /// Percentage of sugar to add (as a decimal, e.g., 0.1 for 10%)
  final double percentage;

  /// Creates a new instance of [SugarAddition]
  SugarAddition({
    required this.name,
    required this.specificGravity,
    required this.percentage,
  }) : assert(percentage < 1, "Percentage must be a decimal");

  /// Factory constructor that takes brix instead of specific gravity
  factory SugarAddition.fromBrix({
    required String name,
    required double brix,
    required double percentage,
  }) {
    return SugarAddition(
      name: name,
      specificGravity: Alcocalc.brixToDensity(brix),
      percentage: percentage,
    );
  }

  /// Get the Brix value calculated from specific gravity
  double get brix => Alcocalc.densityToBrix(specificGravity);

  /// Weight getter for backward compatibility
  /// This should be populated from sugar result calculations
  double get weight => 0.0;

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
