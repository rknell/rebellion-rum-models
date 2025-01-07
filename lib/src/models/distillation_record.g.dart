// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distillation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistillationRecord _$DistillationRecordFromJson(Map<String, dynamic> json) =>
    DistillationRecord(
      id: json['_id'] as String,
      stillUsed: json['stillUsed'] as String,
      feintsAdded: (json['feintsAdded'] as num).toDouble(),
      lalsCharged: (json['lalsCharged'] as num).toDouble(),
      totalLALsCharged: (json['totalLALsCharged'] as num).toDouble(),
      totalLALsYield: (json['totalLALsYield'] as num).toDouble(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DistillationRecordToJson(DistillationRecord instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stillUsed': instance.stillUsed,
      'feintsAdded': instance.feintsAdded,
      'lalsCharged': instance.lalsCharged,
      'totalLALsCharged': instance.totalLALsCharged,
      'totalLALsYield': instance.totalLALsYield,
      'notes': instance.notes.map((e) => e.toJson()).toList(),
    };

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'content': instance.content,
      'date': instance.date.toIso8601String(),
    };
