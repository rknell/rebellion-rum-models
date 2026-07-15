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
      createdAt: jsonToNullableDateTime(json['createdAt']),
      updatedAt: jsonToNullableDateTime(json['updatedAt']),
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
      if (dateTimeToJsonNullable(instance.createdAt) case final value?)
        'createdAt': value,
      if (dateTimeToJsonNullable(instance.updatedAt) case final value?)
        'updatedAt': value,
    };
