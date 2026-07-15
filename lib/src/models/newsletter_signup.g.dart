// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter_signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsletterSignupModel _$NewsletterSignupModelFromJson(
        Map<String, dynamic> json) =>
    NewsletterSignupModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      contactInfo: json['contactInfo'] as String,
      signupDate: jsonToNullableDateTime(json['signupDate']),
      isActive: json['isActive'] as bool? ?? true,
      storefrontId: json['storefrontId'] as String? ?? 'rebellion',
    );

Map<String, dynamic> _$NewsletterSignupModelToJson(
        NewsletterSignupModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'contactInfo': instance.contactInfo,
      if (dateTimeToJsonNullable(instance.signupDate) case final value?)
        'signupDate': value,
      'isActive': instance.isActive,
      'storefrontId': instance.storefrontId,
    };
