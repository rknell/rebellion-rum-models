// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_vessel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageVesselModel _$BulkStorageVesselModelFromJson(
        Map<String, dynamic> json) =>
    BulkStorageVesselModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
      capacity: (json['capacity'] as num).toDouble(),
      remainingLALs: (json['remainingLALs'] as num).toDouble(),
    );

Map<String, dynamic> _$BulkStorageVesselModelToJson(
        BulkStorageVesselModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      if (instance.name case final value?) 'name': value,
      'capacity': instance.capacity,
      'remainingLALs': instance.remainingLALs,
    };
