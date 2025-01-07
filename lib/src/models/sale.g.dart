// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      id: json['_id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      customerId: json['customerId'] as String?,
      coupons: json['coupons'] as Map<String, dynamic>,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      '_id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      if (instance.customerId case final value?) 'customerId': value,
      'coupons': instance.coupons,
      'total': instance.total,
    };
