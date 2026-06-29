// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMaterialDefinitionModel _$RawMaterialDefinitionModelFromJson(
        Map<String, dynamic> json) =>
    RawMaterialDefinitionModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      materialKey: json['materialKey'] as String,
      displayName: json['displayName'] as String,
      unit: json['unit'] as String,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$RawMaterialDefinitionModelToJson(
        RawMaterialDefinitionModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'materialKey': instance.materialKey,
      'displayName': instance.displayName,
      'unit': instance.unit,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
    };
