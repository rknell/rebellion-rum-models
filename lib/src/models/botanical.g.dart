// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'botanical.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BotanicalModel _$BotanicalModelFromJson(Map<String, dynamic> json) =>
    BotanicalModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      botanicalId: (json['id'] as num).toInt(),
      name: json['name'] as String,
      botanicalName: json['botanicalName'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      isActive: json['isActive'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? false,
      productIds: (json['productIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BotanicalModelToJson(BotanicalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'id': instance.botanicalId,
      'name': instance.name,
      'botanicalName': instance.botanicalName,
      'description': instance.description,
      'image': instance.image,
      'isActive': instance.isActive,
      'isFeatured': instance.isFeatured,
      'productIds': instance.productIds,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updatedAt': value,
    };
