// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_vessel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageVesselModel _$BulkStorageVesselModelFromJson(
        Map<String, dynamic> json) =>
    BulkStorageVesselModel(
      id: json['_id'] as String,
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
      capacity: (json['capacity'] as num).toDouble(),
      remainingLALs: (json['remainingLALs'] as num).toDouble(),
    );

Map<String, dynamic> _$BulkStorageVesselModelToJson(
        BulkStorageVesselModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      if (instance.name case final value?) 'name': value,
      'capacity': instance.capacity,
      'remainingLALs': instance.remainingLALs,
    };
