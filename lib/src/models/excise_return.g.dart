// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excise_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExciseReturnModel _$ExciseReturnModelFromJson(Map<String, dynamic> json) =>
    ExciseReturnModel(
      id: json['_id'] as String,
      totalLals: (json['totalLals'] as num).toDouble(),
      remissionApplied: json['remissionApplied'] as bool,
    );

Map<String, dynamic> _$ExciseReturnModelToJson(ExciseReturnModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalLals': instance.totalLals,
      'remissionApplied': instance.remissionApplied,
    };
