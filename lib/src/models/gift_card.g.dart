// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftCardDetails _$GiftCardDetailsFromJson(Map<String, dynamic> json) =>
    GiftCardDetails(
      valueCents: (json['valueCents'] as num).toInt(),
      recipientName: json['recipientName'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      couponCode: json['couponCode'] as String?,
    );

Map<String, dynamic> _$GiftCardDetailsToJson(GiftCardDetails instance) =>
    <String, dynamic>{
      'valueCents': instance.valueCents,
      if (instance.recipientName case final value?) 'recipientName': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      if (instance.couponCode case final value?) 'couponCode': value,
    };
