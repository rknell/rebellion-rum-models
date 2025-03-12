// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_vessel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageVesselModel _$BulkStorageVesselModelFromJson(
        Map<String, dynamic> json) =>
    BulkStorageVesselModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String? ?? '',
      name: json['name'] as String?,
      capacity: (json['capacity'] as num?)?.toDouble() ?? 0,
      currentLals: (json['currentLals'] as num?)?.toDouble() ?? 0,
      status: $enumDecodeNullable(
              _$BulkStorageVesselStatusEnumMap, json['status']) ??
          BulkStorageVesselStatus.active,
      productId: const NullableObjectIdConverter().fromJson(json['productId']),
      needsStocktake: json['needsStocktake'] as bool? ?? false,
    );

Map<String, dynamic> _$BulkStorageVesselModelToJson(
        BulkStorageVesselModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'name': instance.name,
      'capacity': instance.capacity,
      'currentLals': instance.currentLals,
      'status': _$BulkStorageVesselStatusEnumMap[instance.status]!,
      if (const NullableObjectIdConverter().toJson(instance.productId)
          case final value?)
        'productId': value,
      'needsStocktake': instance.needsStocktake,
    };

const _$BulkStorageVesselStatusEnumMap = {
  BulkStorageVesselStatus.active: 'active',
  BulkStorageVesselStatus.decommissioned: 'decommissioned',
  BulkStorageVesselStatus.maintenance: 'maintenance',
};
