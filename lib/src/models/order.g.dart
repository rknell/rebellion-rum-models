// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['_id'] as String,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      items: Map<String, int>.from(json['items'] as Map),
      orderNumber: json['orderNumber'] as String,
      paymentMethod: json['paymentMethod'] as String,
      totalQuote: (json['totalQuote'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      '_id': instance.id,
      'customer': instance.customer.toJson(),
      'date': instance.date.toIso8601String(),
      'items': instance.items,
      'orderNumber': instance.orderNumber,
      'paymentMethod': instance.paymentMethod,
      'totalQuote': instance.totalQuote,
    };
