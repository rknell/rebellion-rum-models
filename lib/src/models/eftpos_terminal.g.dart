// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eftpos_terminal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EftposTerminalModel _$EftposTerminalModelFromJson(Map<String, dynamic> json) =>
    EftposTerminalModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      name: json['name'] as String,
      secret: json['secret'] as String,
      createdAt: jsonToDateTime(json['createdAt']),
      lastUsed: jsonToDateTime(json['lastUsed']),
    );

Map<String, dynamic> _$EftposTerminalModelToJson(
        EftposTerminalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'secret': instance.secret,
      'createdAt': dateTimeToJson(instance.createdAt),
      'lastUsed': dateTimeToJson(instance.lastUsed),
    };
