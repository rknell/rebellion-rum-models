// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      companyName: json['companyName'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      country: json['country'] as String? ?? "Australia",
      preferences: (json['preferences'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$CustomerPreferencesEnumMap, e))
          .toSet(),
      isWholesale: json['isWholesale'] as bool? ?? false,
    )..password = json['password'] as String?;

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (instance.companyName case final value?) 'companyName': value,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'addressLine1': instance.addressLine1,
      if (instance.addressLine2 case final value?) 'addressLine2': value,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
      'isWholesale': instance.isWholesale,
      'preferences': instance.preferences
          .map((e) => _$CustomerPreferencesEnumMap[e]!)
          .toList(),
      if (instance.password case final value?) 'password': value,
    };

const _$CustomerPreferencesEnumMap = {
  CustomerPreferences.darkRum: 'darkRum',
  CustomerPreferences.spicedRum: 'spicedRum',
  CustomerPreferences.whiteRum: 'whiteRum',
  CustomerPreferences.coconutRum: 'coconutRum',
  CustomerPreferences.rum: 'rum',
  CustomerPreferences.gin: 'gin',
  CustomerPreferences.blueGin: 'blueGin',
  CustomerPreferences.pinkGin: 'pinkGin',
  CustomerPreferences.traditionalGin: 'traditionalGin',
  CustomerPreferences.citrusGin: 'citrusGin',
  CustomerPreferences.vodka: 'vodka',
  CustomerPreferences.beer: 'beer',
  CustomerPreferences.other: 'other',
};
