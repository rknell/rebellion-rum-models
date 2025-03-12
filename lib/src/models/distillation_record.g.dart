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
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      status:
          $enumDecodeNullable(_$DistillationStatusEnumMap, json['status']) ??
              DistillationStatus.inProgress,
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
      'startTime': instance.startTime.toIso8601String(),
      'status': _$DistillationStatusEnumMap[instance.status]!,
      'feintsAdded': instance.feintsAdded,
      'lalsCharged': instance.lalsCharged,
      'totalLALsCharged': instance.totalLALsCharged,
      'totalLALsYield': instance.totalLALsYield,
      'notes': instance.notes.map((e) => e.toJson()).toList(),
    };

const _$DistillationStatusEnumMap = {
  DistillationStatus.inProgress: 'inProgress',
  DistillationStatus.completed: 'completed',
  DistillationStatus.archived: 'archived',
};

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      isSystem: json['isSystem'] as bool? ?? false,
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'content': instance.content,
      'date': instance.date.toIso8601String(),
      'isSystem': instance.isSystem,
    };
