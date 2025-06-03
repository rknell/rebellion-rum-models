// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRateModel _$StartShipItRateModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItRateModel(
      serviceName: json['service_name'] as String,
      serviceCode: json['service_code'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
    );

Map<String, dynamic> _$StartShipItRateModelToJson(
        StartShipItRateModel instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'service_code': instance.serviceCode,
      'total_price': instance.totalPrice,
    };
