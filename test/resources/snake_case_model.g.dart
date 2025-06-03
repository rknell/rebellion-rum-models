// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snake_case_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnakeCaseModel _$SnakeCaseModelFromJson(Map<String, dynamic> json) =>
    SnakeCaseModel(
      id: json['_id'] as String,
      userName: json['user_name'] as String,
      emailAddress: json['email_address'] as String,
      phoneNumber: json['phone_number'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      lastLoginTime: json['last_login_time'] == null
          ? null
          : DateTime.parse(json['last_login_time'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      addressInfo: json['address_info'] == null
          ? null
          : AddressInfoModel.fromJson(
              json['address_info'] as Map<String, dynamic>),
      preferenceSettings: (json['preference_settings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$SnakeCaseModelToJson(SnakeCaseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_name': instance.userName,
      'email_address': instance.emailAddress,
      'phone_number': instance.phoneNumber,
      'is_active': instance.isActive,
      'last_login_time': instance.lastLoginTime?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'address_info': instance.addressInfo?.toJson(),
      'preference_settings': instance.preferenceSettings,
    };

AddressInfoModel _$AddressInfoModelFromJson(Map<String, dynamic> json) =>
    AddressInfoModel(
      streetAddress: json['street_address'] as String,
      postalCode: json['postal_code'] as String,
      countryCode: json['country_code'] as String,
    );

Map<String, dynamic> _$AddressInfoModelToJson(AddressInfoModel instance) =>
    <String, dynamic>{
      'street_address': instance.streetAddress,
      'postal_code': instance.postalCode,
      'country_code': instance.countryCode,
    };
