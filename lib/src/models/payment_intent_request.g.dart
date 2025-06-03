// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentRequest _$PaymentIntentRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentRequest(
      address: StartShipItRateDestinationAddressModel.fromJson(
          json['address'] as Map<String, dynamic>),
      items: Map<String, int>.from(json['items'] as Map),
      shippingMethod: json['shipping_method'] as String,
    );

Map<String, dynamic> _$PaymentIntentRequestToJson(
        PaymentIntentRequest instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'items': instance.items,
      'shipping_method': instance.shippingMethod,
    };
