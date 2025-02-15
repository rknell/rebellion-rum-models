// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distillation_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistillationRecordModel _$DistillationRecordModelFromJson(
        Map<String, dynamic> json) =>
    DistillationRecordModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      stillUsed: json['stillUsed'] as String? ?? '',
      feintsAdded: (json['feintsAdded'] as num?)?.toDouble() ?? 0,
      lalsCharged: (json['lalsCharged'] as num?)?.toDouble() ?? 0,
      totalLALsCharged: (json['totalLALsCharged'] as num?)?.toDouble() ?? 0,
      totalLALsYield: (json['totalLALsYield'] as num?)?.toDouble() ?? 0,
      notes: (json['notes'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DistillationRecordModelToJson(
        DistillationRecordModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
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

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for DistillationRecordModel
extension DistillationRecordModelObjectIdFields on DistillationRecordModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
      };
}
