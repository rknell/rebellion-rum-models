// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailing_archive_batch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailingArchiveBatchModel _$MailingArchiveBatchModelFromJson(
        Map<String, dynamic> json) =>
    MailingArchiveBatchModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      batchId: json['batchId'] as String,
      listKey: json['listKey'] as String,
      listName: json['listName'] as String,
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt'] as String),
      reason: json['reason'] as String? ?? 'clear-list',
      memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$MailingArchiveBatchModelToJson(
        MailingArchiveBatchModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'batchId': instance.batchId,
      'listKey': instance.listKey,
      'listName': instance.listName,
      'archivedAt': instance.archivedAt.toIso8601String(),
      'reason': instance.reason,
      'memberCount': instance.memberCount,
    };
