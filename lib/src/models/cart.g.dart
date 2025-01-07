// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['_id'] as String,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      items: Map<String, int>.from(json['items'] as Map),
      appliedCoupons: (json['appliedCoupons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      '_id': instance.id,
      'customer': instance.customer.toJson(),
      'items': instance.items,
      'appliedCoupons': instance.appliedCoupons,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
