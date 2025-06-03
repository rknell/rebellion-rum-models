// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_sender_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRateSenderAddressModel _$StartShipItRateSenderAddressModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItRateSenderAddressModel(
      street: json['street'] as String,
      suburb: json['suburb'] as String,
      state: json['state'] as String,
      postCode: json['post_code'] as String,
      countryCode: json['country_code'] as String,
    );

Map<String, dynamic> _$StartShipItRateSenderAddressModelToJson(
        StartShipItRateSenderAddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suburb': instance.suburb,
      'state': instance.state,
      'post_code': instance.postCode,
      'country_code': instance.countryCode,
    };
