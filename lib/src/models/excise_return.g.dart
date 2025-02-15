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
    );

Map<String, dynamic> _$ExciseReturnModelToJson(ExciseReturnModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'totalLals': instance.totalLals,
      'remissionApplied': instance.remissionApplied,
    };

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for ExciseReturnModel
extension ExciseReturnModelObjectIdFields on ExciseReturnModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
      };
}
