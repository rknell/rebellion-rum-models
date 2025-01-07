// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FermentationRecord _$FermentationRecordFromJson(Map<String, dynamic> json) =>
    FermentationRecord(
      id: json['_id'] as String,
      batchNumber: (json['batchNumber'] as num).toInt(),
      type: json['type'] as String,
      washVolume: (json['washVolume'] as num).toDouble(),
      vesselBarcode: json['vesselBarcode'] as String,
      sgStart: (json['sgStart'] as num).toDouble(),
      sgEnd: (json['sgEnd'] as num).toDouble(),
      fermentationProgress: (json['fermentationProgress'] as List<dynamic>?)
              ?.map((e) =>
                  FermentationProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$FermentationRecordToJson(FermentationRecord instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'batchNumber': instance.batchNumber,
      'type': instance.type,
      'washVolume': instance.washVolume,
      'vesselBarcode': instance.vesselBarcode,
      'sgStart': instance.sgStart,
      'sgEnd': instance.sgEnd,
      'fermentationProgress':
          instance.fermentationProgress.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
    };

FermentationProgress _$FermentationProgressFromJson(
        Map<String, dynamic> json) =>
    FermentationProgress(
      sg: (json['sg'] as num).toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      temp: (json['temp'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$FermentationProgressToJson(
        FermentationProgress instance) =>
    <String, dynamic>{
      'sg': instance.sg,
      if (instance.ph case final value?) 'ph': value,
      if (instance.temp case final value?) 'temp': value,
      'timestamp': instance.timestamp.toIso8601String(),
      'notes': instance.notes,
    };
