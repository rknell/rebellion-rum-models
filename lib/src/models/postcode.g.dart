// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostcodeModel _$PostcodeModelFromJson(Map<String, dynamic> json) =>
    PostcodeModel(
      id: json['_id'] as String,
      postcode: json['postcode'] as String,
      locality: json['locality'] as String,
      state: json['state'] as String,
      combined: json['combined'] as String,
    );

Map<String, dynamic> _$PostcodeModelToJson(PostcodeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'postcode': instance.postcode,
      'locality': instance.locality,
      'state': instance.state,
      'combined': instance.combined,
    };
