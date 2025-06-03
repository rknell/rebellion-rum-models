// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_shipping_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeShippingDetails _$StripeShippingDetailsFromJson(
        Map<String, dynamic> json) =>
    StripeShippingDetails(
      address: json['address'] == null
          ? null
          : StripeAddress.fromJson(json['address'] as Map<String, dynamic>),
      carrier: json['carrier'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      trackingNumber: json['tracking_number'] as String?,
    );

Map<String, dynamic> _$StripeShippingDetailsToJson(
        StripeShippingDetails instance) =>
    <String, dynamic>{
      if (instance.address?.toJson() case final value?) 'address': value,
      if (instance.carrier case final value?) 'carrier': value,
      if (instance.name case final value?) 'name': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.trackingNumber case final value?) 'tracking_number': value,
    };
