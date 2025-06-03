// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingQuoteRequestModel _$ShippingQuoteRequestModelFromJson(
        Map<String, dynamic> json) =>
    ShippingQuoteRequestModel(
      address: StartShipItRateDestinationAddressModel.fromJson(
          json['address'] as Map<String, dynamic>),
      items: Map<String, int>.from(json['items'] as Map),
    );

Map<String, dynamic> _$ShippingQuoteRequestModelToJson(
        ShippingQuoteRequestModel instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'items': instance.items,
    };

StartShipItRateDestinationAddressModel
    _$StartShipItRateDestinationAddressModelFromJson(
            Map<String, dynamic> json) =>
        StartShipItRateDestinationAddressModel(
          street: json['street'] as String,
          suburb: json['suburb'] as String,
          city: json['city'] as String,
          state: json['state'] as String,
          postCode: json['post_code'] as String,
          countryCode: json['country_code'] as String,
        );

Map<String, dynamic> _$StartShipItRateDestinationAddressModelToJson(
        StartShipItRateDestinationAddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suburb': instance.suburb,
      'city': instance.city,
      'state': instance.state,
      'post_code': instance.postCode,
      'country_code': instance.countryCode,
    };
