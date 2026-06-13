// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailing_send.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailingSendModel _$MailingSendModelFromJson(Map<String, dynamic> json) =>
    MailingSendModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      listKey: json['listKey'] as String,
      archiveBatchId: json['archiveBatchId'] as String?,
      subject: json['subject'] as String,
      htmlBody: json['htmlBody'] as String,
      textBody: json['textBody'] as String,
      smsBody: json['smsBody'] as String?,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      emailedCount: (json['emailedCount'] as num?)?.toInt() ?? 0,
      skippedPhoneOnlyCount:
          (json['skippedPhoneOnlyCount'] as num?)?.toInt() ?? 0,
      suppressedGlobalCount:
          (json['suppressedGlobalCount'] as num?)?.toInt() ?? 0,
      suppressedListCount: (json['suppressedListCount'] as num?)?.toInt() ?? 0,
      skippedPhones: (json['skippedPhones'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MailingSendModelToJson(MailingSendModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'listKey': instance.listKey,
      if (instance.archiveBatchId case final value?) 'archiveBatchId': value,
      'subject': instance.subject,
      'htmlBody': instance.htmlBody,
      'textBody': instance.textBody,
      if (instance.smsBody case final value?) 'smsBody': value,
      'sentAt': instance.sentAt.toIso8601String(),
      'emailedCount': instance.emailedCount,
      'skippedPhoneOnlyCount': instance.skippedPhoneOnlyCount,
      'suppressedGlobalCount': instance.suppressedGlobalCount,
      'suppressedListCount': instance.suppressedListCount,
      'skippedPhones': instance.skippedPhones,
    };
