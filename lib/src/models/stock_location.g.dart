// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockLocationModel _$StockLocationModelFromJson(Map<String, dynamic> json) =>
    StockLocationModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      barcode: json['barcode'] as String,
      isBondStore: json['isBondStore'] as bool,
      isRetail: json['isRetail'] as bool,
      isAvailableOnline: json['isAvailableOnline'] as bool,
      isWarehouse: json['isWarehouse'] as bool,
      stockLevels: (json['stockLevels'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$StockLocationModelToJson(StockLocationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'isBondStore': instance.isBondStore,
      'isRetail': instance.isRetail,
      'isAvailableOnline': instance.isAvailableOnline,
      'isWarehouse': instance.isWarehouse,
      if (instance.stockLevels case final value?) 'stockLevels': value,
    };
