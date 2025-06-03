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
      commissionedDate: DateTime.parse(json['commissionedDate'] as String),
      decommissionedDate: json['decommissionedDate'] == null
          ? null
          : DateTime.parse(json['decommissionedDate'] as String),
    );

Map<String, dynamic> _$StillModelToJson(StillModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'capacityLiters': instance.capacityLiters,
      'description': instance.description,
      'isActive': instance.isActive,
      'commissionedDate': instance.commissionedDate.toIso8601String(),
      if (instance.decommissionedDate?.toIso8601String() case final value?)
        'decommissionedDate': value,
    };
