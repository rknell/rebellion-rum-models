// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      items: Map<String, int>.from(json['items'] as Map),
      orderNumber: json['orderNumber'] as String,
      paymentMethod: json['paymentMethod'] as String?,
      totalQuote: (json['totalQuote'] as num).toDouble(),
      paymentReceipt: json['paymentReceipt'] as Map<String, dynamic>?,
      shippingMethod: json['shippingMethod'] as String?,
      shippingReceipt: json['shippingReceipt'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'customer': instance.customer.toJson(),
      'date': instance.date.toIso8601String(),
      'items': instance.items,
      'orderNumber': instance.orderNumber,
      if (instance.paymentMethod case final value?) 'paymentMethod': value,
      if (instance.paymentReceipt case final value?) 'paymentReceipt': value,
      if (instance.shippingMethod case final value?) 'shippingMethod': value,
      if (instance.shippingReceipt case final value?) 'shippingReceipt': value,
      'totalQuote': instance.totalQuote,
    };
