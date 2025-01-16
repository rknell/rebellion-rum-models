// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postcode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostcodeModel _$PostcodeModelFromJson(Map<String, dynamic> json) =>
    PostcodeModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      postcode: json['postcode'] as String,
      locality: json['locality'] as String,
      state: json['state'] as String,
      combined: json['combined'] as String,
    );

Map<String, dynamic> _$PostcodeModelToJson(PostcodeModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'postcode': instance.postcode,
      'locality': instance.locality,
      'state': instance.state,
      'combined': instance.combined,
    };
