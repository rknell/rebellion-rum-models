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
      unitVolumeMl: (json['unitVolumeMl'] as num?)?.toDouble(),
      unitAbv: (json['unitAbv'] as num?)?.toDouble(),
      lalPerUnit: (json['lalPerUnit'] as num?)?.toDouble(),
      totalLals: (json['totalLals'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SaleItemModelToJson(SaleItemModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'price': instance.price,
      'itemId': instance.itemId,
      'qty': instance.qty,
      if (instance.unitVolumeMl case final value?) 'unitVolumeMl': value,
      if (instance.unitAbv case final value?) 'unitAbv': value,
      if (instance.lalPerUnit case final value?) 'lalPerUnit': value,
      if (instance.totalLals case final value?) 'totalLals': value,
    };
