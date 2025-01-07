// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['_id'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      discount: (json['discount'] as num).toDouble(),
      isPercentage: json['isPercentage'] as bool,
      isEnabled: json['isEnabled'] as bool,
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      maxUses: (json['maxUses'] as num?)?.toInt(),
      usedCount: (json['usedCount'] as num).toInt(),
      applicableProducts: (json['applicableProducts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'description': instance.description,
      'discount': instance.discount,
      'isPercentage': instance.isPercentage,
      'isEnabled': instance.isEnabled,
      if (instance.expiryDate?.toIso8601String() case final value?)
        'expiryDate': value,
      if (instance.maxUses case final value?) 'maxUses': value,
      'usedCount': instance.usedCount,
      'applicableProducts': instance.applicableProducts,
    };
