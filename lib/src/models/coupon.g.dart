// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['_id'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      email: json['email'] as String,
      phone: json['phone'] as String?,
      redeemed: json['redeemed'] as bool?,
      remainingValue: (json['remainingValue'] as num?)?.toDouble(),
      originalAmount: (json['originalAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'amount': instance.amount,
      'email': instance.email,
      if (instance.phone case final value?) 'phone': value,
      if (instance.redeemed case final value?) 'redeemed': value,
      if (instance.remainingValue case final value?) 'remainingValue': value,
      if (instance.originalAmount case final value?) 'originalAmount': value,
    };
