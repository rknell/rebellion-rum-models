// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excise_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExciseReturnModel _$ExciseReturnModelFromJson(Map<String, dynamic> json) =>
    ExciseReturnModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      totalLals: (json['totalLals'] as num).toDouble(),
      remissionApplied: json['remissionApplied'] as bool,
    )..referenceNumber = json['referenceNumber'] as String?;

Map<String, dynamic> _$ExciseReturnModelToJson(ExciseReturnModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'totalLals': instance.totalLals,
      'remissionApplied': instance.remissionApplied,
      if (instance.referenceNumber case final value?) 'referenceNumber': value,
    };
