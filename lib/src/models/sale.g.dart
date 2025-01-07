// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      id: json['_id'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => SaleItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      customerId: json['customerId'] as String?,
      coupons: json['coupons'],
      total: (json['total'] as num?)?.toDouble(),
      discountTotal: (json['discountTotal'] as num?)?.toDouble(),
      eftposSessionId: json['eftposSessionId'] as String?,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      '_id': instance.id,
      if (instance.timestamp?.toIso8601String() case final value?)
        'timestamp': value,
      'items': instance.items.map((e) => e.toJson()).toList(),
      if (instance.customerId case final value?) 'customerId': value,
      if (instance.coupons case final value?) 'coupons': value,
      if (instance.total case final value?) 'total': value,
      if (instance.discountTotal case final value?) 'discountTotal': value,
      if (instance.eftposSessionId case final value?) 'eftposSessionId': value,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
    };
