// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_register_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageRegisterItemModel _$BulkStorageRegisterItemModelFromJson(
        Map<String, dynamic> json) =>
    BulkStorageRegisterItemModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      lalsCalculation: json['lalsCalculation'] == null
          ? null
          : AlcocalcLalsCalculation.fromJson(
              json['lalsCalculation'] as Map<String, dynamic>),
      legacyLals: (json['lals'] as num?)?.toDouble(),
      movementType: $enumDecodeNullable(
              _$BulkStorageMovementTypeEnumMap, json['movementType']) ??
          BulkStorageMovementType.vesselTransfer,
      feintsDestroyed: json['feintsDestroyed'] as bool? ?? false,
      wastage: json['wastage'] as bool? ?? false,
      notes: json['notes'] as String?,
      fromChargeId: json['fromChargeId'] as String?,
      fromVesselId:
          const NullableObjectIdConverter().fromJson(json['fromVesselId']),
      toVesselId:
          const NullableObjectIdConverter().fromJson(json['toVesselId']),
      toChargeId:
          const NullableObjectIdConverter().fromJson(json['toChargeId']),
      toPackagingId:
          const NullableObjectIdConverter().fromJson(json['toPackagingId']),
      fromPackagingId:
          const NullableObjectIdConverter().fromJson(json['fromPackagingId']),
      productId: const NullableObjectIdConverter().fromJson(json['productId']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$BulkStorageRegisterItemModelToJson(
        BulkStorageRegisterItemModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (instance.lalsCalculation?.toJson() case final value?)
        'lalsCalculation': value,
      if (instance.legacyLals case final value?) 'lals': value,
      'movementType': _$BulkStorageMovementTypeEnumMap[instance.movementType]!,
      'feintsDestroyed': instance.feintsDestroyed,
      'wastage': instance.wastage,
      if (instance.notes case final value?) 'notes': value,
      if (instance.fromChargeId case final value?) 'fromChargeId': value,
      if (const NullableObjectIdConverter().toJson(instance.fromVesselId)
          case final value?)
        'fromVesselId': value,
      if (const NullableObjectIdConverter().toJson(instance.toVesselId)
          case final value?)
        'toVesselId': value,
      if (const NullableObjectIdConverter().toJson(instance.toChargeId)
          case final value?)
        'toChargeId': value,
      if (const NullableObjectIdConverter().toJson(instance.toPackagingId)
          case final value?)
        'toPackagingId': value,
      if (const NullableObjectIdConverter().toJson(instance.fromPackagingId)
          case final value?)
        'fromPackagingId': value,
      if (const NullableObjectIdConverter().toJson(instance.productId)
          case final value?)
        'productId': value,
      if (instance.timestamp?.toIso8601String() case final value?)
        'timestamp': value,
    };

const _$BulkStorageMovementTypeEnumMap = {
  BulkStorageMovementType.fromStill: 'fromStill',
  BulkStorageMovementType.vesselTransfer: 'vesselTransfer',
  BulkStorageMovementType.toStill: 'toStill',
  BulkStorageMovementType.toPackaging: 'toPackaging',
  BulkStorageMovementType.underbond: 'underbond',
  BulkStorageMovementType.feintsDestroyed: 'feintsDestroyed',
  BulkStorageMovementType.manufacture: 'manufacture',
  BulkStorageMovementType.stocktake: 'stocktake',
  BulkStorageMovementType.wastage: 'wastage',
};

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for BulkStorageRegisterItemModel
extension BulkStorageRegisterItemModelObjectIdFields
    on BulkStorageRegisterItemModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
        'fromPackagingId',
        'fromVesselId',
        'productId',
        'toChargeId',
        'toPackagingId',
        'toVesselId',
      };
}
