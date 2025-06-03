// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_material_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMaterialTypeModel _$RawMaterialTypeModelFromJson(
        Map<String, dynamic> json) =>
    RawMaterialTypeModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      name: json['name'] as String,
      specificGravity: (json['specificGravity'] as num).toDouble(),
    );

Map<String, dynamic> _$RawMaterialTypeModelToJson(
        RawMaterialTypeModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'specificGravity': instance.specificGravity,
    };
