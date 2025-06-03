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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastUsed: json['lastUsed'] == null
          ? null
          : DateTime.parse(json['lastUsed'] as String),
    );

Map<String, dynamic> _$EftposTerminalModelToJson(
        EftposTerminalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'secret': instance.secret,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastUsed': instance.lastUsed.toIso8601String(),
    };
