// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_vessel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageVessel _$BulkStorageVesselFromJson(Map<String, dynamic> json) =>
    BulkStorageVessel(
      id: json['_id'] as String,
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
      capacity: (json['capacity'] as num).toDouble(),
      remainingLALs: (json['remainingLALs'] as num).toDouble(),
    );

Map<String, dynamic> _$BulkStorageVesselToJson(BulkStorageVessel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      if (instance.name case final value?) 'name': value,
      'capacity': instance.capacity,
      'remainingLALs': instance.remainingLALs,
    };
