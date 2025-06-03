// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRatePackageModel _$StartShipItRatePackageModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItRatePackageModel(
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StartShipItRatePackageModelToJson(
        StartShipItRatePackageModel instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      if (instance.height case final value?) 'height': value,
      if (instance.width case final value?) 'width': value,
      if (instance.length case final value?) 'length': value,
    };
