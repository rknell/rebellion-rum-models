// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postcode _$PostcodeFromJson(Map<String, dynamic> json) => Postcode(
      id: json['_id'] as String,
      postcode: json['postcode'] as String,
      suburb: json['suburb'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$PostcodeToJson(Postcode instance) => <String, dynamic>{
      '_id': instance.id,
      'postcode': instance.postcode,
      'suburb': instance.suburb,
      'state': instance.state,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
