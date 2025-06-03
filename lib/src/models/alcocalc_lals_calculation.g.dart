// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alcocalc_lals_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlcocalcLalsCalculation _$AlcocalcLalsCalculationFromJson(
        Map<String, dynamic> json) =>
    AlcocalcLalsCalculation(
      weight: (json['weight'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
    );

Map<String, dynamic> _$AlcocalcLalsCalculationToJson(
        AlcocalcLalsCalculation instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'abv': instance.abv,
      'temperature': instance.temperature,
    };
