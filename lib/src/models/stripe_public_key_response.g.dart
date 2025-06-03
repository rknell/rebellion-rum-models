// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_public_key_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripePublicKeyResponse _$StripePublicKeyResponseFromJson(
        Map<String, dynamic> json) =>
    StripePublicKeyResponse(
      publishableKey: json['publishable_key'] as String,
      success: json['success'] as bool,
    );

Map<String, dynamic> _$StripePublicKeyResponseToJson(
        StripePublicKeyResponse instance) =>
    <String, dynamic>{
      'publishable_key': instance.publishableKey,
      'success': instance.success,
    };
