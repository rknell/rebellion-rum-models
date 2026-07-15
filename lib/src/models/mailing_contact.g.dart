// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailing_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailingContactModel _$MailingContactModelFromJson(Map<String, dynamic> json) =>
    MailingContactModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      normalizedEmail: json['normalizedEmail'] as String,
      normalizedPhone: json['normalizedPhone'] as String,
      displayContact: json['displayContact'] as String,
      storefrontId: json['storefrontId'] as String? ?? 'rebellion',
      source: json['source'] as String? ?? 'unknown',
      createdAt: jsonToDateTime(json['createdAt']),
      updatedAt: jsonToDateTime(json['updatedAt']),
      globalEmailOptOut: json['globalEmailOptOut'] as bool? ?? false,
      globalSmsOptOut: json['globalSmsOptOut'] as bool? ?? false,
      globalOptOutAt: jsonToNullableDateTime(json['globalOptOutAt']),
    );

Map<String, dynamic> _$MailingContactModelToJson(
        MailingContactModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (instance.email case final value?) 'email': value,
      if (instance.phone case final value?) 'phone': value,
      'normalizedEmail': instance.normalizedEmail,
      'normalizedPhone': instance.normalizedPhone,
      'displayContact': instance.displayContact,
      'storefrontId': instance.storefrontId,
      'source': instance.source,
      'createdAt': dateTimeToJson(instance.createdAt),
      'updatedAt': dateTimeToJson(instance.updatedAt),
      'globalEmailOptOut': instance.globalEmailOptOut,
      'globalSmsOptOut': instance.globalSmsOptOut,
      if (dateTimeToJsonNullable(instance.globalOptOutAt) case final value?)
        'globalOptOutAt': value,
    };
