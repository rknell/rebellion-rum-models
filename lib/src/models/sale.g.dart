// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleModel _$SaleModelFromJson(Map<String, dynamic> json) => SaleModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => SaleItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      customerId: json['customerId'] as String?,
      coupons: SaleModel._couponsFromJson(json['coupons']),
      total: (json['total'] as num?)?.toDouble(),
      discountTotal: (json['discountTotal'] as num?)?.toDouble(),
      eftposSessionId: json['eftposSessionId'] as String?,
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isMatesRates: json['isMatesRates'] as bool?,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      status: $enumDecodeNullable(_$SaleStatusEnumMap, json['status'],
              unknownValue: SaleStatus.unpaid) ??
          SaleStatus.unpaid,
    );

Map<String, dynamic> _$SaleModelToJson(SaleModel instance) => <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'timestamp': instance.timestamp.toIso8601String(),
      if (instance.dueDate?.toIso8601String() case final value?)
        'dueDate': value,
      'status': _$SaleStatusEnumMap[instance.status]!,
      'items': instance.items.map((e) => e.toJson()).toList(),
      if (instance.customerId case final value?) 'customerId': value,
      'coupons': instance.coupons.map((e) => e.toJson()).toList(),
      if (instance.total case final value?) 'total': value,
      if (instance.discountTotal case final value?) 'discountTotal': value,
      if (instance.eftposSessionId case final value?) 'eftposSessionId': value,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'isMatesRates': instance.isMatesRates,
    };

const _$SaleStatusEnumMap = {
  SaleStatus.unpaid: 'unpaid',
  SaleStatus.paid: 'paid',
};
