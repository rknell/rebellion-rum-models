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
      createdAt: jsonToDateTime(json['createdAt']),
      updatedAt: jsonToDateTime(json['updatedAt']),
      archiveBatchId: json['archiveBatchId'] as String?,
      archivedAt: jsonToNullableDateTime(json['archivedAt']),
      listOptOutAt: jsonToNullableDateTime(json['listOptOutAt']),
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
      'createdAt': dateTimeToJson(instance.createdAt),
      'updatedAt': dateTimeToJson(instance.updatedAt),
      if (instance.archiveBatchId case final value?) 'archiveBatchId': value,
      if (dateTimeToJsonNullable(instance.archivedAt) case final value?)
        'archivedAt': value,
      if (dateTimeToJsonNullable(instance.listOptOutAt) case final value?)
        'listOptOutAt': value,
    };
