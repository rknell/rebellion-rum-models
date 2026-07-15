// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_transferred_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeTransferredRecordModel _$VolumeTransferredRecordModelFromJson(
        Map<String, dynamic> json) =>
    VolumeTransferredRecordModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      chargeId: const ObjectIdConverter().fromJson(json['chargeId']),
      washId: const ObjectIdConverter().fromJson(json['washId']),
      volume: (json['volume'] as num).toDouble(),
      lals: (json['lals'] as num).toDouble(),
      abvPercent: (json['abvPercent'] as num?)?.toDouble(),
      strengthMethod: $enumDecodeNullable(
              _$WashStrengthMethodEnumMap, json['strengthMethod']) ??
          WashStrengthMethod.unknown,
      timestamp: jsonToNullableDateTime(json['timestamp']),
    );

Map<String, dynamic> _$VolumeTransferredRecordModelToJson(
        VolumeTransferredRecordModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (const ObjectIdConverter().toJson(instance.chargeId) case final value?)
        'chargeId': value,
      if (const ObjectIdConverter().toJson(instance.washId) case final value?)
        'washId': value,
      'volume': instance.volume,
      'lals': instance.lals,
      if (instance.abvPercent case final value?) 'abvPercent': value,
      'strengthMethod': _$WashStrengthMethodEnumMap[instance.strengthMethod]!,
      if (dateTimeToJsonNullable(instance.timestamp) case final value?)
        'timestamp': value,
    };

const _$WashStrengthMethodEnumMap = {
  WashStrengthMethod.unknown: 'unknown',
  WashStrengthMethod.estimatedFromSg: 'estimatedFromSg',
  WashStrengthMethod.measured: 'measured',
  WashStrengthMethod.manual: 'manual',
};
