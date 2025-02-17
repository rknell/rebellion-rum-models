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
      feintsDestroyed: json['feintsDestroyed'] as bool? ?? false,
      wastage: json['wastage'] as bool? ?? false,
      isStocktake: json['isStocktake'] as bool? ?? false,
      notes: json['notes'] as String?,
      fromChargeId:
          const NullableObjectIdConverter().fromJson(json['fromChargeId']),
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
    );

Map<String, dynamic> _$BulkStorageRegisterItemModelToJson(
        BulkStorageRegisterItemModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (instance.lalsCalculation?.toJson() case final value?)
        'lalsCalculation': value,
      if (instance.legacyLals case final value?) 'lals': value,
      'isStocktake': instance.isStocktake,
      'feintsDestroyed': instance.feintsDestroyed,
      'wastage': instance.wastage,
      if (instance.notes case final value?) 'notes': value,
      if (const NullableObjectIdConverter().toJson(instance.fromChargeId)
          case final value?)
        'fromChargeId': value,
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
        'fromChargeId',
        'fromPackagingId',
        'fromVesselId',
        'productId',
        'toChargeId',
        'toPackagingId',
        'toVesselId',
      };
}
