// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distillation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistillationRecordModel _$DistillationRecordModelFromJson(
        Map<String, dynamic> json) =>
    DistillationRecordModel(
      id: json['_id'] as String,
      stillUsed: json['stillUsed'] as String,
      feintsAdded: (json['feintsAdded'] as num).toDouble(),
      lalsCharged: (json['lalsCharged'] as num).toDouble(),
      totalLALsCharged: (json['totalLALsCharged'] as num).toDouble(),
      totalLALsYield: (json['totalLALsYield'] as num).toDouble(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DistillationRecordModelToJson(
        DistillationRecordModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stillUsed': instance.stillUsed,
      'feintsAdded': instance.feintsAdded,
      'lalsCharged': instance.lalsCharged,
      'totalLALsCharged': instance.totalLALsCharged,
      'totalLALsYield': instance.totalLALsYield,
      'notes': instance.notes.map((e) => e.toJson()).toList(),
    };

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'content': instance.content,
      'date': instance.date.toIso8601String(),
    };
