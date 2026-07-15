// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'still.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StillModel _$StillModelFromJson(Map<String, dynamic> json) => StillModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      name: json['name'] as String,
      capacityLiters: (json['capacityLiters'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      commissionedDate: jsonToDateTime(json['commissionedDate']),
      decommissionedDate: jsonToNullableDateTime(json['decommissionedDate']),
    );

Map<String, dynamic> _$StillModelToJson(StillModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'capacityLiters': instance.capacityLiters,
      'description': instance.description,
      'isActive': instance.isActive,
      'commissionedDate': dateTimeToJson(instance.commissionedDate),
      if (dateTimeToJsonNullable(instance.decommissionedDate) case final value?)
        'decommissionedDate': value,
    };
