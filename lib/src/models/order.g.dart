// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      customerId:
          const NullableObjectIdConverter().fromJson(json['customerId']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      items: Map<String, int>.from(json['items'] as Map),
      orderNumber: json['orderNumber'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status'],
              unknownValue: OrderStatus.pending) ??
          OrderStatus.pending,
      totalQuote: (json['totalQuote'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      paymentIntentClientSecret: json['paymentIntentClientSecret'] as String?,
      shippingMethod: json['shippingMethod'] as String?,
      shippingReceipt: json['shippingReceipt'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    )..customer = json['customer'] == null
        ? null
        : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (const NullableObjectIdConverter().toJson(instance.customerId)
          case final value?)
        'customerId': value,
      if (instance.customer?.toJson() case final value?) 'customer': value,
      'date': instance.date.toIso8601String(),
      'items': instance.items,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.paymentMethod case final value?) 'paymentMethod': value,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'metadata': instance.metadata,
      if (instance.paymentIntentClientSecret case final value?)
        'paymentIntentClientSecret': value,
      if (instance.shippingMethod case final value?) 'shippingMethod': value,
      if (instance.shippingReceipt case final value?) 'shippingReceipt': value,
      if (instance.totalQuote case final value?) 'totalQuote': value,
      if (instance.notes case final value?) 'notes': value,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.pending: 'pending',
  OrderStatus.paid: 'paid',
  OrderStatus.shipped: 'shipped',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};
