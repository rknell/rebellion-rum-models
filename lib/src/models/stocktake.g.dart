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
      timestamp: jsonToDateTime(json['timestamp']),
    );

Map<String, dynamic> _$StocktakeModelToJson(StocktakeModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'materialType': instance.materialType,
      'currentStock': instance.currentStock,
      'newCount': instance.newCount,
      'timestamp': dateTimeToJson(instance.timestamp),
    };
