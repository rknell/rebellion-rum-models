// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailing_list_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailingListMembershipModel _$MailingListMembershipModelFromJson(
        Map<String, dynamic> json) =>
    MailingListMembershipModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      contactId: const ObjectIdConverter().fromJson(json['contactId']),
      listKey: json['listKey'] as String,
      status: json['status'] as String? ?? 'active',
      source: json['source'] as String? ?? 'unknown',
      consentType: json['consentType'] as String? ?? 'express',
      storefrontId: json['storefrontId'] as String? ?? 'rebellion',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      archiveBatchId: json['archiveBatchId'] as String?,
      archivedAt: json['archivedAt'] == null
          ? null
          : DateTime.parse(json['archivedAt'] as String),
      listOptOutAt: json['listOptOutAt'] == null
          ? null
          : DateTime.parse(json['listOptOutAt'] as String),
    );

Map<String, dynamic> _$MailingListMembershipModelToJson(
        MailingListMembershipModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (const ObjectIdConverter().toJson(instance.contactId)
          case final value?)
        'contactId': value,
      'listKey': instance.listKey,
      'status': instance.status,
      'source': instance.source,
      'consentType': instance.consentType,
      'storefrontId': instance.storefrontId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      if (instance.archiveBatchId case final value?) 'archiveBatchId': value,
      if (instance.archivedAt?.toIso8601String() case final value?)
        'archivedAt': value,
      if (instance.listOptOutAt?.toIso8601String() case final value?)
        'listOptOutAt': value,
    };
