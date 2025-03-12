import 'package:alcocalc/alcocalc.dart' as alcocalc;
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

// # Alcocalc Library API Documentation
//
// NOTE: This is a summary of the Alcocalc API. For complete documentation,
// please refer to the AlcoCalc_api.md file in the documentation directory.
//
// ## Major Changes in v2.0
//
// The library has been significantly refactored:
// 1. All functions are now static methods on the `Alcocalc` class
// 2. Result objects have more properties and better documentation
// 3. Sugar handling has been improved with the `SugarResult` class
//
// ## Key Static Methods
//
// - `Alcocalc.diluteByWeight`: Calculates dilution by weight using OIML tables
// - `Alcocalc.dilution`: Calculates a dilution with optional sugar additions
// - `Alcocalc.diluteToVolume`: Calculates a dilution to achieve a specific target volume
// - `Alcocalc.diluteToBottles`: Calculates a dilution to produce a specific number of bottles
// - `Alcocalc.calculateAlcoholAddition`: Calculates how much high-proof alcohol to add
// - `Alcocalc.correctedABV`: Corrects ABV for temperature using OIML tables
// - `Alcocalc.abvToAbw`: Converts ABV to ABW
// - `Alcocalc.litresOfAlcoholCalculation`: Calculates the total litres of pure alcohol (LALs)
//
// ## Key Classes
//
// - `DiluteByWeightResult`: Contains all calculated values from a dilution by weight operation
// - `DilutionResult`: Represents the complete result of a dilution operation
// - `SugarResult`: Represents a sugar addition in a dilution operation
// - `Sugars`: Defines a type of sugar to be used in dilution calculations
// - `AlcoholAdditionResult`: Contains the results of an alcohol addition calculation
//
// ## Usage Examples
//
// ```dart
// // Dilution by weight
// final result = Alcocalc.diluteByWeight(
//   startingABV: 0.60,      // 60% ABV
//   startingTemperature: 20, // 20°C
//   targetABV: 0.40,        // 40% ABV
//   startingWeight: 10.0,    // 10kg
// );
//
// // Dilution with sugar
// final sugars = [
//   Sugars(name: 'Simple syrup', specificGravity: 1.33, percentage: 0.05),
// ];
//
// final result = Alcocalc.dilution(
//   startingWeight: 10.0,
//   startingABV: 0.60,
//   startingTemperature: 20,
//   sugars: sugars,
//   targetABV: 0.40,
// );
//
// // Adding high-proof alcohol
// final result = Alcocalc.calculateAlcoholAddition(
//   currentWeight: 20.0,
//   currentABV: 0.35,
//   targetABV: 0.40,
//   additionABV: 0.962,
//   temperature: 20.0,
// );
// ```

part 'alcocalc_dilution_calculation.g.dart';

/// Represents a sugar to be used in dilution calculations.
@JsonSerializable()
class SugarInputModel {
  /// Name of the sugar
  final String name;

  /// Specific gravity of the sugar
  final double specificGravity;

  /// Percentage of the sugar in the solution (as a decimal)
  final double percentage;

  /// Gets the sugar content in degrees Brix (°Bx) by converting the specific gravity
  double get brix => alcocalc.Alcocalc.densityToBrix(specificGravity);

  SugarInputModel({
    required this.name,
    required this.specificGravity,
    required this.percentage,
  });

  /// Converts this model to the Alcocalc Sugars class
  alcocalc.Sugars toAlcoCalc() {
    return alcocalc.Sugars(
      name: name,
      specificGravity: specificGravity,
      percentage: percentage,
    );
  }

  /// Creates a SugarModel from an Alcocalc Sugars instance
  factory SugarInputModel.fromAlcoCalc(alcocalc.Sugars sugar) {
    return SugarInputModel(
      name: sugar.name,
      specificGravity: sugar.specificGravity,
      percentage: sugar.percentage,
    );
  }

  factory SugarInputModel.fromBrix({
    required String name,
    required double degreesBrix,
    required double percentage,
  }) {
    final specificGravity = alcocalc.Alcocalc.brixToDensity(degreesBrix);
    return SugarInputModel(
      name: name,
      specificGravity: specificGravity,
      percentage: percentage,
    );
  }

  factory SugarInputModel.fromJson(Map<String, dynamic> json) =>
      _$SugarInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$SugarInputModelToJson(this);
}

/// Represents the input parameters for a dilution calculation.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionInputModel {
  /// Initial weight in kilograms
  final double startingWeight;

  /// Initial alcohol by volume as a decimal (e.g., 0.40 for 40%)
  final double startingABV;

  /// Temperature in Celsius
  final double startingTemperature;

  /// Optional list of sugars to add to the dilution
  final List<SugarInputModel> sugars;

  /// Desired final alcohol by volume as a decimal
  final double targetABV;

  /// Reference to the product being diluted
  @NullableObjectIdConverter()
  final ObjectId? productId;

  /// Optional bottle size in liters for dilution calculations
  final double bottleSize;

  /// Timestamp of when this calculation was created
  final DateTime createdAt;

  AlcocalcDilutionInputModel({
    required this.startingWeight,
    required this.startingABV,
    required this.startingTemperature,
    this.sugars = const [],
    required this.targetABV,
    this.productId,
    this.bottleSize = 0.7,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AlcocalcDilutionInputModel.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcocalcDilutionInputModelToJson(this);

  Set<String> get objectIdFields => {'_id', 'productId'};
}

/// Represents a sugar addition result in a dilution operation.
/// The equivalent AlcoCalc class is alcocalc.SugarResult
@JsonSerializable()
class SugarResultModel {
  /// Name of the sugar
  final String name;

  /// Weight of sugar to add in kilograms
  final double weight;

  /// Cumulative weight including this sugar and all previous sugars
  final double runningWeight;

  SugarResultModel(
      {required this.name, required this.weight, required this.runningWeight});

  /// Creates a SugarResultModel from an Alcocalc SugarResult instance
  factory SugarResultModel.fromAlcoCalcSugarResult(
      alcocalc.SugarResult result) {
    return SugarResultModel(
        name: result.name,
        weight: result.weight,
        runningWeight: result.runningWeight);
  }

  /// Converts this model to an Alcocalc Sugar instance
  alcocalc.SugarResult toAlcoCalcSugarResult() {
    return alcocalc.SugarResult(
        name: name, weight: weight, runningWeight: runningWeight);
  }

  factory SugarResultModel.fromJson(Map<String, dynamic> json) =>
      _$SugarResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SugarResultModelToJson(this);
}

/// Represents the complete result of a dilution calculation.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionResultModel {
  /// Date when the calculation was performed
  final DateTime date;

  /// Initial weight in kilograms
  final double startingWeight;

  /// Temperature-corrected initial ABV
  final double correctedStartingABV;

  /// Litres of pure alcohol
  final double lals;

  /// Amount of water to add in litres
  final double additionalWaterLitres;

  /// Target weight after adding water
  final double targetWeightAfterWater;

  /// Calculated final ABV
  final double calculatedABV;

  /// Lower acceptable ABV limit
  final double acceptableABVLow;

  /// Upper acceptable ABV limit
  final double acceptableABVHigh;

  /// List of sugar additions
  final List<SugarResultModel> sugarResults;

  /// Target volume after dilution
  final double targetVolume;

  /// Expected number of bottles
  final double expectedBottles;

  /// Target final weight in kilograms after all additions
  final double targetFinalWeight;

  AlcocalcDilutionResultModel({
    required this.date,
    required this.startingWeight,
    required this.correctedStartingABV,
    required this.lals,
    required this.additionalWaterLitres,
    required this.targetWeightAfterWater,
    required this.calculatedABV,
    required this.acceptableABVLow,
    required this.acceptableABVHigh,
    required this.sugarResults,
    required this.targetVolume,
    required this.expectedBottles,
    required this.targetFinalWeight,
  });

  /// Creates an AlcocalcDilutionResultModel from an Alcocalc DilutionResult instance
  factory AlcocalcDilutionResultModel.fromAlcoCalc(
      alcocalc.DilutionResult result) {
    return AlcocalcDilutionResultModel(
      date: result.date,
      startingWeight: result.startingWeight,
      correctedStartingABV: result.correctedStartingABV,
      lals: result.lals,
      additionalWaterLitres: result.additionalWaterLitres,
      targetWeightAfterWater: result.targetWeightAfterWater,
      calculatedABV: result.calculatedABV,
      acceptableABVLow: result.acceptableABVLow,
      acceptableABVHigh: result.acceptableABVHigh,
      sugarResults: result.sugarResults
          .map((s) => SugarResultModel.fromAlcoCalcSugarResult(s))
          .toList(),
      targetVolume: result.targetVolume,
      expectedBottles: result.expectedBottles,
      targetFinalWeight: result.targetFinalWeight,
    );
  }

  /// Creates an Alcocalc DilutionResult from this model
  alcocalc.DilutionResult toAlcoCalc() {
    return alcocalc.DilutionResult(
      startingWeight: startingWeight,
      correctedStartingABV: correctedStartingABV,
      lals: lals,
      additionalWaterLitres: additionalWaterLitres,
      targetWeightAfterWater: targetWeightAfterWater,
      calculatedABV: calculatedABV,
      sugarResults: sugarResults.map((s) => s.toAlcoCalcSugarResult()).toList(),
      targetVolume: targetVolume,
      expectedBottles: expectedBottles,
      targetFinalWeight: targetFinalWeight,
    );
  }

  factory AlcocalcDilutionResultModel.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcocalcDilutionResultModelToJson(this);
}

/// Represents the result of an alcohol addition calculation.
@JsonSerializable(explicitToJson: true)
class AlcoholAdditionResultModel {
  /// The current weight of the original liquid in kilograms
  final double currentWeight;

  /// The original ABV of the liquid as a decimal
  final double currentABV;

  /// The desired target ABV as a decimal
  final double targetABV;

  /// The ABV of the alcohol being added as a decimal
  final double additionABV;

  /// The temperature in Celsius at which the calculation is performed
  final double temperature;

  /// ABV corrected for temperature effects
  final double correctedCurrentABV;

  /// ABV of the addition corrected for temperature effects
  final double correctedAdditionABV;

  /// The density of the original liquid in kg/L
  final double currentDensity;

  /// The density of the alcohol being added in kg/L
  final double additionDensity;

  /// The density of the resulting mixture in kg/L
  final double targetDensity;

  /// The volume of the original liquid in liters
  final double currentVolume;

  /// The volume of pure alcohol in the original liquid in liters
  final double currentAlcoholVolume;

  /// The volume of alcohol to be added in liters
  final double additionVolume;

  /// The weight of high-proof alcohol that needs to be added in kilograms
  final double requiredAlcoholWeight;

  /// The total weight after addition in kilograms
  final double finalWeight;

  /// The total volume after addition in liters
  final double finalVolume;

  /// Liters of Absolute Alcohol (LALs) added
  final double lals;

  /// Date when the calculation was performed
  final DateTime createdAt;

  AlcoholAdditionResultModel({
    required this.currentWeight,
    required this.currentABV,
    required this.targetABV,
    required this.additionABV,
    required this.temperature,
    required this.correctedCurrentABV,
    required this.correctedAdditionABV,
    required this.currentDensity,
    required this.additionDensity,
    required this.targetDensity,
    required this.currentVolume,
    required this.currentAlcoholVolume,
    required this.additionVolume,
    required this.requiredAlcoholWeight,
    required this.finalWeight,
    required this.finalVolume,
    required this.lals,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Creates an AlcoholAdditionResultModel from an Alcocalc AlcoholAdditionResult instance
  factory AlcoholAdditionResultModel.fromAlcoCalc(
    alcocalc.AlcoholAdditionResult result,
  ) {
    return AlcoholAdditionResultModel(
      currentWeight: result.currentWeight,
      currentABV: result.currentABV,
      targetABV: result.targetABV,
      additionABV: result.additionABV,
      temperature: result.temperature,
      correctedCurrentABV: result.correctedCurrentABV,
      correctedAdditionABV: result.correctedAdditionABV,
      currentDensity: result.currentDensity,
      additionDensity: result.additionDensity,
      targetDensity: result.targetDensity,
      currentVolume: result.currentVolume,
      currentAlcoholVolume: result.currentAlcoholVolume,
      additionVolume: result.additionVolume,
      requiredAlcoholWeight: result.requiredAlcoholWeight,
      finalWeight: result.finalWeight,
      finalVolume: result.finalVolume,
      lals: result.lals,
    );
  }

  factory AlcoholAdditionResultModel.fromJson(Map<String, dynamic> json) =>
      _$AlcoholAdditionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcoholAdditionResultModelToJson(this);
}
