// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocktake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StocktakeModel _$StocktakeModelFromJson(Map<String, dynamic> json) =>
    StocktakeModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      materialType: json['materialType'] as String,
      currentStock: (json['currentStock'] as num).toInt(),
      newCount: (json['newCount'] as num).toInt(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$StocktakeModelToJson(StocktakeModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'materialType': instance.materialType,
      'currentStock': instance.currentStock,
      'newCount': instance.newCount,
      'timestamp': instance.timestamp.toIso8601String(),
    };
