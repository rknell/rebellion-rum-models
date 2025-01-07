// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleItemModel _$SaleItemModelFromJson(Map<String, dynamic> json) =>
    SaleItemModel(
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      itemId: json['itemId'] as String,
      qty: (json['qty'] as num).toInt(),
    );

Map<String, dynamic> _$SaleItemModelToJson(SaleItemModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'price': instance.price,
      'itemId': instance.itemId,
      'qty': instance.qty,
    };
