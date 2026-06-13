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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      globalEmailOptOut: json['globalEmailOptOut'] as bool? ?? false,
      globalSmsOptOut: json['globalSmsOptOut'] as bool? ?? false,
      globalOptOutAt: json['globalOptOutAt'] == null
          ? null
          : DateTime.parse(json['globalOptOutAt'] as String),
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
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'globalEmailOptOut': instance.globalEmailOptOut,
      'globalSmsOptOut': instance.globalSmsOptOut,
      if (instance.globalOptOutAt?.toIso8601String() case final value?)
        'globalOptOutAt': value,
    };
