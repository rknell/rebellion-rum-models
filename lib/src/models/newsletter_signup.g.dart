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
      signupDate: json['signupDate'] == null
          ? null
          : DateTime.parse(json['signupDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$NewsletterSignupModelToJson(
        NewsletterSignupModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'contactInfo': instance.contactInfo,
      if (instance.signupDate?.toIso8601String() case final value?)
        'signupDate': value,
      'isActive': instance.isActive,
    };
