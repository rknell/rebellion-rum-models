// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excise_return.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExciseReturn _$ExciseReturnFromJson(Map<String, dynamic> json) => ExciseReturn(
      id: json['_id'] as String,
      totalLals: (json['totalLals'] as num).toDouble(),
      remissionApplied: json['remissionApplied'] as bool,
    );

Map<String, dynamic> _$ExciseReturnToJson(ExciseReturn instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalLals': instance.totalLals,
      'remissionApplied': instance.remissionApplied,
    };
