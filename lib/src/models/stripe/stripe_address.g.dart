// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeAddress _$StripeAddressFromJson(Map<String, dynamic> json) =>
    StripeAddress(
      city: json['city'] as String?,
      country: json['country'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postalCode: json['postal_code'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$StripeAddressToJson(StripeAddress instance) =>
    <String, dynamic>{
      if (instance.city case final value?) 'city': value,
      if (instance.country case final value?) 'country': value,
      if (instance.line1 case final value?) 'line1': value,
      if (instance.line2 case final value?) 'line2': value,
      if (instance.postalCode case final value?) 'postal_code': value,
      if (instance.state case final value?) 'state': value,
    };
