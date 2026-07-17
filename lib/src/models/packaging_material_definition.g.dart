// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_material_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingMaterialDefinitionModel _$PackagingMaterialDefinitionModelFromJson(
        Map<String, dynamic> json) =>
    PackagingMaterialDefinitionModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      type: $enumDecode(_$PackagingMaterialTypeEnumMap, json['type']),
      displayName: json['displayName'] as String,
      unit: json['unit'] as String? ?? 'each',
      warningThreshold: (json['warningThreshold'] as num?)?.toInt() ?? 600,
      isActive: json['isActive'] as bool? ?? true,
      productBarcode: json['productBarcode'] as String?,
      labelTareWeightGrams: (json['labelTareWeightGrams'] as num?)?.toDouble(),
      tenLabelSampleWeightGrams:
          (json['tenLabelSampleWeightGrams'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PackagingMaterialDefinitionModelToJson(
        PackagingMaterialDefinitionModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'type': _$PackagingMaterialTypeEnumMap[instance.type]!,
      'displayName': instance.displayName,
      'unit': instance.unit,
      'warningThreshold': instance.warningThreshold,
      'isActive': instance.isActive,
      if (instance.productBarcode case final value?) 'productBarcode': value,
      if (instance.labelTareWeightGrams case final value?)
        'labelTareWeightGrams': value,
      if (instance.tenLabelSampleWeightGrams case final value?)
        'tenLabelSampleWeightGrams': value,
    };

const _$PackagingMaterialTypeEnumMap = {
  PackagingMaterialType.bottle: 'bottle',
  PackagingMaterialType.cap: 'cap',
  PackagingMaterialType.sleeve: 'sleeve',
  PackagingMaterialType.label: 'label',
};
