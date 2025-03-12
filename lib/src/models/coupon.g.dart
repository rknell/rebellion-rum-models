// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      code: json['code'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      redeemed: json['redeemed'] as bool?,
      remainingValue: (json['remainingValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'code': instance.code,
      'description': instance.description,
      'amount': instance.amount,
      if (instance.email case final value?) 'email': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.redeemed case final value?) 'redeemed': value,
      'remainingValue': instance.remainingValue,
    };
