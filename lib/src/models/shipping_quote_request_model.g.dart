// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_quote_request_model.dart';

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
