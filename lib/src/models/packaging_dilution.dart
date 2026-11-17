import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_dilution_calculation.dart';

part 'packaging_dilution.g.dart';

/// How portions feed the single packaging run; neither mode creates sub-batches.
enum PackagingDilutionMode { homogenised, continuous }

/// One independently weighed, diluted and checked portion of a packaging run.
@JsonSerializable(explicitToJson: true)
class PackagingDilutionModel {
  final String id;
  final AlcocalcDilutionResultModel? calculation;
  final double? abvReading;

  /// Optional scale totals: index 0 is after water, then each sugar in order.
  /// Missing/null means the planned totals apply. Null entries use the plan
  /// from the preceding actual total; recipe addition masses stay unchanged.
  final List<double?>? actualWeightsKg;

  PackagingDilutionModel({
    required this.id,
    this.calculation,
    this.abvReading,
    this.actualWeightsKg,
  });

  bool get isChecked =>
      calculation != null &&
      abvReading != null &&
      abvReading! >= calculation!.acceptableABVLow &&
      abvReading! <= calculation!.acceptableABVHigh;

  factory PackagingDilutionModel.fromJson(Map<String, dynamic> json) {
    validateJson(json);
    return _$PackagingDilutionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    final json = _$PackagingDilutionModelToJson(this);
    validateJson(json);
    return json;
  }

  static void validateJson(Map<String, dynamic> json) {
    final id = json['id'];
    Never invalid(String field) => throw FormatException(
        'Packaging dilution ${id ?? "<missing id>"}: invalid $field');
    if (id is! String || id.trim().isEmpty) invalid('id');
    final abv = json['abvReading'];
    if (abv != null && (abv is! num || !abv.isFinite || abv < 0 || abv > 1)) {
      invalid('abvReading');
    }
    final weights = json['actualWeightsKg'];
    if (weights != null) {
      if (weights is! List) invalid('actualWeightsKg');
      for (var i = 0; i < weights.length; i++) {
        final value = weights[i];
        if (value != null && (value is! num || !value.isFinite || value < 0)) {
          invalid('actualWeightsKg[$i]');
        }
      }
    }
    final calculation = json['calculation'];
    if (calculation == null) {
      if (abv != null) invalid('abvReading without calculation');
      if (weights != null) invalid('actualWeightsKg without calculation');
      return; // A deliberately unfinished dilution is valid.
    }
    if (calculation is! Map<String, dynamic>) invalid('calculation');
    for (final field in [
      'startingWeight',
      'correctedStartingABV',
      'lals',
      'additionalWaterLitres',
      'targetWeightAfterWater',
      'calculatedABV',
      'acceptableABVLow',
      'acceptableABVHigh',
      'targetVolume',
      'expectedBottles',
      'targetFinalWeight'
    ]) {
      final value = calculation[field];
      if (value is! num || !value.isFinite || value < 0) {
        invalid('calculation.$field');
      }
    }
    for (final field in [
      'correctedStartingABV',
      'calculatedABV',
      'acceptableABVLow',
      'acceptableABVHigh'
    ]) {
      if ((calculation[field] as num) > 1) invalid('calculation.$field');
    }
    final date = calculation['date'];
    if (date is! String || DateTime.tryParse(date) == null) {
      invalid('calculation.date');
    }
    final sugars = calculation['sugarResults'];
    if (sugars is! List) invalid('calculation.sugarResults');
    if (weights is List && weights.length != sugars.length + 1) {
      invalid('actualWeightsKg length');
    }
    for (final sugar in sugars) {
      if (sugar is! Map || sugar['name'] is! String) {
        invalid('calculation.sugarResults');
      }
      for (final field in ['weight', 'runningWeight']) {
        final value = sugar[field];
        if (value is! num || !value.isFinite || value < 0) {
          invalid('calculation.sugarResults.$field');
        }
      }
    }
  }
}
