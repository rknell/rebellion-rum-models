// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_get_rates_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItGetRatesRequestModel _$StartShipItGetRatesRequestModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItGetRatesRequestModel(
      sender: json['sender'] == null
          ? null
          : StartShipItRateSenderAddressModel.fromJson(
              json['sender'] as Map<String, dynamic>),
      destination: StartShipItRateDestinationAddressModel.fromJson(
          json['destination'] as Map<String, dynamic>),
      packages: (json['packages'] as List<dynamic>)
          .map((e) =>
              StartShipItRatePackageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currency: json['currency'] as String? ?? "AUD",
    );

Map<String, dynamic> _$StartShipItGetRatesRequestModelToJson(
        StartShipItGetRatesRequestModel instance) =>
    <String, dynamic>{
      if (instance.sender?.toJson() case final value?) 'sender': value,
      'destination': instance.destination.toJson(),
      'packages': instance.packages.map((e) => e.toJson()).toList(),
      'currency': instance.currency,
    };
