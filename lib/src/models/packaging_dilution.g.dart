// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_dilution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingDilutionModel _$PackagingDilutionModelFromJson(
        Map<String, dynamic> json) =>
    PackagingDilutionModel(
      id: json['id'] as String,
      calculation: json['calculation'] == null
          ? null
          : AlcocalcDilutionResultModel.fromJson(
              json['calculation'] as Map<String, dynamic>),
      abvReading: (json['abvReading'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PackagingDilutionModelToJson(
        PackagingDilutionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.calculation?.toJson() case final value?)
        'calculation': value,
      if (instance.abvReading case final value?) 'abvReading': value,
    };
