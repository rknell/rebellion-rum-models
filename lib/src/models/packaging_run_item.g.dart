// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packaging_run_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagingRunItemModel _$PackagingRunItemModelFromJson(
        Map<String, dynamic> json) =>
    PackagingRunItemModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      productBarcode: json['productBarcode'] as String,
      unitSize: (json['unitSize'] as num).toDouble(),
      strength: (json['strength'] as num).toDouble(),
      unitsPackaged: (json['unitsPackaged'] as num).toDouble(),
      packagingLosses: (json['packagingLosses'] as num).toDouble(),
      remaining: (json['remaining'] as num).toDouble(),
      volumeAvailable: (json['volumeAvailable'] as num).toDouble(),
      volumeRemaining: (json['volumeRemaining'] as num).toDouble(),
      targetBottles: (json['targetBottles'] as num?)?.toInt() ?? 0,
      status: $enumDecodeNullable(_$PackagingRunStatusEnumMap, json['status'],
              unknownValue: PackagingRunStatus.excised) ??
          PackagingRunStatus.inProgress,
      estimatedProduct: json['estimatedProduct'] == null
          ? null
          : AlcocalcDilutionCalculation.fromJson(
              json['estimatedProduct'] as Map<String, dynamic>),
      secondaryDilution: json['secondaryDilution'] == null
          ? null
          : AlcocalcDilutionCalculation.fromJson(
              json['secondaryDilution'] as Map<String, dynamic>),
      abvReading: (json['abvReading'] as num?)?.toDouble(),
      exciseReturn:
          const NullableObjectIdConverter().fromJson(json['exciseReturn']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      discrepancyNote: json['discrepancyNote'] as String?,
      completionDate: json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String),
    );

Map<String, dynamic> _$PackagingRunItemModelToJson(
        PackagingRunItemModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'productBarcode': instance.productBarcode,
      'unitSize': instance.unitSize,
      'strength': instance.strength,
      'unitsPackaged': instance.unitsPackaged,
      'packagingLosses': instance.packagingLosses,
      'remaining': instance.remaining,
      'volumeAvailable': instance.volumeAvailable,
      'volumeRemaining': instance.volumeRemaining,
      if (instance.estimatedProduct?.toJson() case final value?)
        'estimatedProduct': value,
      if (instance.secondaryDilution?.toJson() case final value?)
        'secondaryDilution': value,
      if (instance.abvReading case final value?) 'abvReading': value,
      'targetBottles': instance.targetBottles,
      if (instance.timestamp?.toIso8601String() case final value?)
        'timestamp': value,
      if (instance.completionDate?.toIso8601String() case final value?)
        'completionDate': value,
      'status': _$PackagingRunStatusEnumMap[instance.status]!,
      if (const NullableObjectIdConverter().toJson(instance.exciseReturn)
          case final value?)
        'exciseReturn': value,
      if (instance.discrepancyNote case final value?) 'discrepancyNote': value,
    };

const _$PackagingRunStatusEnumMap = {
  PackagingRunStatus.inProgress: 'inProgress',
  PackagingRunStatus.awaitingExcise: 'awaitingExcise',
  PackagingRunStatus.complete: 'complete',
  PackagingRunStatus.excised: 'excised',
};

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for PackagingRunItemModel
extension PackagingRunItemModelObjectIdFields on PackagingRunItemModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
        'exciseReturn',
      };
}
