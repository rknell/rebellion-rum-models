// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_run_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingRunItemModel _$PackagingRunItemModelFromJson(
        Map<String, dynamic> json) =>
    PackagingRunItemModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      productBarcode: json['productBarcode'] as String,
      unitSize: (json['unitSize'] as num).toDouble(),
      strength: (json['strength'] as num).toDouble(),
      unitsPackaged: (json['unitsPackaged'] as num).toDouble(),
      packagingLosses: (json['packagingLosses'] as num).toDouble(),
      remaining: (json['remaining'] as num).toDouble(),
      volumeAvailable: (json['volumeAvailable'] as num).toDouble(),
      volumeRemaining: (json['volumeRemaining'] as num).toDouble(),
      exciseReturn: json['exciseReturn'] as String,
    );

Map<String, dynamic> _$PackagingRunItemModelToJson(
        PackagingRunItemModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'productBarcode': instance.productBarcode,
      'unitSize': instance.unitSize,
      'strength': instance.strength,
      'unitsPackaged': instance.unitsPackaged,
      'packagingLosses': instance.packagingLosses,
      'remaining': instance.remaining,
      'volumeAvailable': instance.volumeAvailable,
      'volumeRemaining': instance.volumeRemaining,
      'exciseReturn': instance.exciseReturn,
    };
