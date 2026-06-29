// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FermentationRecordModel _$FermentationRecordModelFromJson(
        Map<String, dynamic> json) =>
    FermentationRecordModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      batchNumber: (json['batchNumber'] as num).toInt(),
      type: $enumDecode(_$FermentationTypeEnumMap, json['type'],
          unknownValue: FermentationType.other),
      washVolume: (json['washVolume'] as num).toDouble(),
      vesselBarcode: json['vesselBarcode'] as String,
      sgStart: (json['sgStart'] as num).toDouble(),
      sgEnd: (json['sgEnd'] as num).toDouble(),
      finalStrengthPercent: (json['finalStrengthPercent'] as num?)?.toDouble(),
      finalStrengthMethod: json['finalStrengthMethod'] as String? ?? '',
      finalStrengthTimestamp: json['finalStrengthTimestamp'] == null
          ? null
          : DateTime.parse(json['finalStrengthTimestamp'] as String),
      fermentationProgress: (json['fermentationProgress'] as List<dynamic>?)
          ?.map((e) =>
              FermentationProgressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String? ?? '',
      recipe: json['recipe'] as String? ?? '',
      completed: json['completed'] as bool? ?? false,
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$FermentationRecordModelToJson(
        FermentationRecordModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'batchNumber': instance.batchNumber,
      'type': _$FermentationTypeEnumMap[instance.type]!,
      'washVolume': instance.washVolume,
      'vesselBarcode': instance.vesselBarcode,
      'sgStart': instance.sgStart,
      'sgEnd': instance.sgEnd,
      if (instance.finalStrengthPercent case final value?)
        'finalStrengthPercent': value,
      'finalStrengthMethod': instance.finalStrengthMethod,
      if (instance.finalStrengthTimestamp?.toIso8601String() case final value?)
        'finalStrengthTimestamp': value,
      'fermentationProgress':
          instance.fermentationProgress.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
      'recipe': instance.recipe,
      'completed': instance.completed,
      if (instance.completionDate?.toIso8601String() case final value?)
        'completionDate': value,
      'isDeleted': instance.isDeleted,
      if (instance.deletedAt?.toIso8601String() case final value?)
        'deletedAt': value,
    };

const _$FermentationTypeEnumMap = {
  FermentationType.molasses: 'molasses',
  FermentationType.caneSugar: 'caneSugar',
  FermentationType.grape: 'grape',
  FermentationType.grain: 'grain',
  FermentationType.mixed: 'mixed',
  FermentationType.other: 'other',
};

FermentationProgressModel _$FermentationProgressModelFromJson(
        Map<String, dynamic> json) =>
    FermentationProgressModel(
      sg: (json['sg'] as num).toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      temp: (json['temp'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$FermentationProgressModelToJson(
        FermentationProgressModel instance) =>
    <String, dynamic>{
      'sg': instance.sg,
      if (instance.ph case final value?) 'ph': value,
      if (instance.temp case final value?) 'temp': value,
      'timestamp': instance.timestamp.toIso8601String(),
      'notes': instance.notes,
    };
