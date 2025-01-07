// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_register_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageRegisterItem _$BulkStorageRegisterItemFromJson(
        Map<String, dynamic> json) =>
    BulkStorageRegisterItem(
      id: json['_id'] as String,
      lals: (json['lals'] as num).toDouble(),
      feintsDestroyed: json['feintsDestroyed'] as bool,
      wastage: json['wastage'] as bool,
      notes: json['notes'] as String,
      fromChargeId: json['fromChargeId'] as String?,
      fromVesselId: json['fromVesselId'] as String?,
      toVesselId: json['toVesselId'] as String?,
      toChargeId: json['toChargeId'] as String?,
      toPackagingId: json['toPackagingId'] as String?,
      fromPackagingId: json['fromPackagingId'] as String?,
    );

Map<String, dynamic> _$BulkStorageRegisterItemToJson(
        BulkStorageRegisterItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'lals': instance.lals,
      'feintsDestroyed': instance.feintsDestroyed,
      'wastage': instance.wastage,
      'notes': instance.notes,
      if (instance.fromChargeId case final value?) 'fromChargeId': value,
      if (instance.fromVesselId case final value?) 'fromVesselId': value,
      if (instance.toVesselId case final value?) 'toVesselId': value,
      if (instance.toChargeId case final value?) 'toChargeId': value,
      if (instance.toPackagingId case final value?) 'toPackagingId': value,
      if (instance.fromPackagingId case final value?) 'fromPackagingId': value,
    };
