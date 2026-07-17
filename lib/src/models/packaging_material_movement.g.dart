// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_material_movement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingMaterialMovementModel _$PackagingMaterialMovementModelFromJson(
        Map<String, dynamic> json) =>
    PackagingMaterialMovementModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      materialDefinitionId:
          const ObjectIdConverter().fromJson(json['materialDefinitionId']),
      materialType:
          $enumDecode(_$PackagingMaterialTypeEnumMap, json['materialType']),
      quantityDelta: (json['quantityDelta'] as num).toDouble(),
      movementType: $enumDecode(
          _$PackagingMaterialMovementTypeEnumMap, json['movementType']),
      sourceSystem: json['sourceSystem'] as String,
      sourceDocumentType: json['sourceDocumentType'] as String,
      sourceDocumentId: json['sourceDocumentId'] as String,
      idempotencyKey: json['idempotencyKey'] as String,
      note: json['note'] as String?,
      actor: json['actor'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PackagingMaterialMovementModelToJson(
        PackagingMaterialMovementModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (const ObjectIdConverter().toJson(instance.materialDefinitionId)
          case final value?)
        'materialDefinitionId': value,
      'materialType': _$PackagingMaterialTypeEnumMap[instance.materialType]!,
      'quantityDelta': instance.quantityDelta,
      'movementType':
          _$PackagingMaterialMovementTypeEnumMap[instance.movementType]!,
      'sourceSystem': instance.sourceSystem,
      'sourceDocumentType': instance.sourceDocumentType,
      'sourceDocumentId': instance.sourceDocumentId,
      'idempotencyKey': instance.idempotencyKey,
      if (instance.note case final value?) 'note': value,
      if (instance.actor case final value?) 'actor': value,
      'timestamp': instance.timestamp.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$PackagingMaterialTypeEnumMap = {
  PackagingMaterialType.bottle: 'bottle',
  PackagingMaterialType.cap: 'cap',
  PackagingMaterialType.sleeve: 'sleeve',
  PackagingMaterialType.label: 'label',
};

const _$PackagingMaterialMovementTypeEnumMap = {
  PackagingMaterialMovementType.purchase: 'purchase',
  PackagingMaterialMovementType.bottleReturn: 'bottleReturn',
  PackagingMaterialMovementType.packagingRunConsumption:
      'packagingRunConsumption',
  PackagingMaterialMovementType.labelStocktake: 'labelStocktake',
  PackagingMaterialMovementType.stocktake: 'stocktake',
  PackagingMaterialMovementType.adjustment: 'adjustment',
};
