// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alcocalc_dilution_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SugarInputModel _$SugarInputModelFromJson(Map<String, dynamic> json) =>
    SugarInputModel(
      name: json['name'] as String,
      specificGravity: (json['specificGravity'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
    );

Map<String, dynamic> _$SugarInputModelToJson(SugarInputModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'specificGravity': instance.specificGravity,
      'percentage': instance.percentage,
    };

AlcocalcDilutionInputModel _$AlcocalcDilutionInputModelFromJson(
        Map<String, dynamic> json) =>
    AlcocalcDilutionInputModel(
      startingWeight: (json['startingWeight'] as num).toDouble(),
      startingABV: (json['startingABV'] as num).toDouble(),
      startingTemperature: (json['startingTemperature'] as num).toDouble(),
      sugars: (json['sugars'] as List<dynamic>?)
              ?.map((e) => SugarInputModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      targetABV: (json['targetABV'] as num).toDouble(),
      productId: const NullableObjectIdConverter().fromJson(json['productId']),
      bottleSize: (json['bottleSize'] as num?)?.toDouble() ?? 0.7,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AlcocalcDilutionInputModelToJson(
        AlcocalcDilutionInputModel instance) =>
    <String, dynamic>{
      'startingWeight': instance.startingWeight,
      'startingABV': instance.startingABV,
      'startingTemperature': instance.startingTemperature,
      'sugars': instance.sugars.map((e) => e.toJson()).toList(),
      'targetABV': instance.targetABV,
      if (const NullableObjectIdConverter().toJson(instance.productId)
          case final value?)
        'productId': value,
      'bottleSize': instance.bottleSize,
      'createdAt': instance.createdAt.toIso8601String(),
    };

SugarResultModel _$SugarResultModelFromJson(Map<String, dynamic> json) =>
    SugarResultModel(
      name: json['name'] as String,
      weight: (json['weight'] as num).toDouble(),
      runningWeight: (json['runningWeight'] as num).toDouble(),
    );

Map<String, dynamic> _$SugarResultModelToJson(SugarResultModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'weight': instance.weight,
      'runningWeight': instance.runningWeight,
    };

AlcocalcDilutionResultModel _$AlcocalcDilutionResultModelFromJson(
        Map<String, dynamic> json) =>
    AlcocalcDilutionResultModel(
      date: DateTime.parse(json['date'] as String),
      startingWeight: (json['startingWeight'] as num).toDouble(),
      correctedStartingABV: (json['correctedStartingABV'] as num).toDouble(),
      lals: (json['lals'] as num).toDouble(),
      additionalWaterLitres: (json['additionalWaterLitres'] as num).toDouble(),
      targetWeightAfterWater:
          (json['targetWeightAfterWater'] as num).toDouble(),
      calculatedABV: (json['calculatedABV'] as num).toDouble(),
      acceptableABVLow: (json['acceptableABVLow'] as num).toDouble(),
      acceptableABVHigh: (json['acceptableABVHigh'] as num).toDouble(),
      sugarResults: (json['sugarResults'] as List<dynamic>)
          .map((e) => SugarResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetVolume: (json['targetVolume'] as num).toDouble(),
      expectedBottles: (json['expectedBottles'] as num).toDouble(),
      targetFinalWeight: (json['targetFinalWeight'] as num).toDouble(),
    );

Map<String, dynamic> _$AlcocalcDilutionResultModelToJson(
        AlcocalcDilutionResultModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'startingWeight': instance.startingWeight,
      'correctedStartingABV': instance.correctedStartingABV,
      'lals': instance.lals,
      'additionalWaterLitres': instance.additionalWaterLitres,
      'targetWeightAfterWater': instance.targetWeightAfterWater,
      'calculatedABV': instance.calculatedABV,
      'acceptableABVLow': instance.acceptableABVLow,
      'acceptableABVHigh': instance.acceptableABVHigh,
      'sugarResults': instance.sugarResults.map((e) => e.toJson()).toList(),
      'targetVolume': instance.targetVolume,
      'expectedBottles': instance.expectedBottles,
      'targetFinalWeight': instance.targetFinalWeight,
    };

AlcoholAdditionResultModel _$AlcoholAdditionResultModelFromJson(
        Map<String, dynamic> json) =>
    AlcoholAdditionResultModel(
      currentWeight: (json['currentWeight'] as num).toDouble(),
      currentABV: (json['currentABV'] as num).toDouble(),
      targetABV: (json['targetABV'] as num).toDouble(),
      additionABV: (json['additionABV'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
      correctedCurrentABV: (json['correctedCurrentABV'] as num).toDouble(),
      correctedAdditionABV: (json['correctedAdditionABV'] as num).toDouble(),
      currentDensity: (json['currentDensity'] as num).toDouble(),
      additionDensity: (json['additionDensity'] as num).toDouble(),
      targetDensity: (json['targetDensity'] as num).toDouble(),
      currentVolume: (json['currentVolume'] as num).toDouble(),
      currentAlcoholVolume: (json['currentAlcoholVolume'] as num).toDouble(),
      additionVolume: (json['additionVolume'] as num).toDouble(),
      requiredAlcoholWeight: (json['requiredAlcoholWeight'] as num).toDouble(),
      finalWeight: (json['finalWeight'] as num).toDouble(),
      finalVolume: (json['finalVolume'] as num).toDouble(),
      lals: (json['lals'] as num).toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$AlcoholAdditionResultModelToJson(
        AlcoholAdditionResultModel instance) =>
    <String, dynamic>{
      'currentWeight': instance.currentWeight,
      'currentABV': instance.currentABV,
      'targetABV': instance.targetABV,
      'additionABV': instance.additionABV,
      'temperature': instance.temperature,
      'correctedCurrentABV': instance.correctedCurrentABV,
      'correctedAdditionABV': instance.correctedAdditionABV,
      'currentDensity': instance.currentDensity,
      'additionDensity': instance.additionDensity,
      'targetDensity': instance.targetDensity,
      'currentVolume': instance.currentVolume,
      'currentAlcoholVolume': instance.currentAlcoholVolume,
      'additionVolume': instance.additionVolume,
      'requiredAlcoholWeight': instance.requiredAlcoholWeight,
      'finalWeight': instance.finalWeight,
      'finalVolume': instance.finalVolume,
      'lals': instance.lals,
      'createdAt': instance.createdAt.toIso8601String(),
    };
