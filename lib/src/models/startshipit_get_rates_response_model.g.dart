// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_get_rates_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItGetRatesResponseModel _$StartShipItGetRatesResponseModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItGetRatesResponseModel(
      rates: (json['rates'] as List<dynamic>)
          .map((e) => StartShipItRateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$StartShipItGetRatesResponseModelToJson(
        StartShipItGetRatesResponseModel instance) =>
    <String, dynamic>{
      'rates': instance.rates.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
