// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_destination_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRateDestinationAddressModel
    _$StartShipItRateDestinationAddressModelFromJson(
            Map<String, dynamic> json) =>
        StartShipItRateDestinationAddressModel(
          street: json['street'] as String,
          suburb: json['suburb'] as String,
          state: json['state'] as String,
          postCode: json['post_code'] as String,
          countryCode: json['country_code'] as String? ?? 'AU',
        );

Map<String, dynamic> _$StartShipItRateDestinationAddressModelToJson(
        StartShipItRateDestinationAddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suburb': instance.suburb,
      'state': instance.state,
      'post_code': instance.postCode,
      'country_code': instance.countryCode,
    };
