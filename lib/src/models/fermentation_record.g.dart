// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fermentation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FermentationRecordModel _$FermentationRecordModelFromJson(
        Map<String, dynamic> json) =>
    FermentationRecordModel(
      id: json['_id'] as String,
      batchNumber: (json['batchNumber'] as num).toInt(),
      type: json['type'] as String,
      washVolume: (json['washVolume'] as num).toDouble(),
      vesselBarcode: json['vesselBarcode'] as String,
      sgStart: (json['sgStart'] as num).toDouble(),
      sgEnd: (json['sgEnd'] as num).toDouble(),
      fermentationProgress: (json['fermentationProgress'] as List<dynamic>?)
              ?.map((e) =>
                  FermentationProgressModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$FermentationRecordModelToJson(
        FermentationRecordModel instance) =>
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
