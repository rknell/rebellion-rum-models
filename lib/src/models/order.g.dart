// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['_id'] as String,
      customer:
          CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      items: Map<String, int>.from(json['items'] as Map),
      orderNumber: json['orderNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      totalQuote: (json['totalQuote'] as num).toDouble(),
      paymentReceipt: json['paymentReceipt'] as Map<String, dynamic>?,
      shippingMethod: json['shippingMethod'] as String?,
      shippingReceipt: json['shippingReceipt'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'customer': instance.customer.toJson(),
      'date': instance.date.toIso8601String(),
      'items': instance.items,
      'orderNumber': instance.orderNumber,
      'paymentMethod': instance.paymentMethod,
      if (instance.paymentReceipt case final value?) 'paymentReceipt': value,
      if (instance.shippingMethod case final value?) 'shippingMethod': value,
      if (instance.shippingReceipt case final value?) 'shippingReceipt': value,
      'totalQuote': instance.totalQuote,
    };
