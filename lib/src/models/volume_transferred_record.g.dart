// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_transferred_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeTransferredRecordModel _$VolumeTransferredRecordModelFromJson(
        Map<String, dynamic> json) =>
    VolumeTransferredRecordModel(
      id: json['_id'] as String,
      chargeId: json['chargeId'] as String,
      washId: json['washId'] as String,
      volume: (json['volume'] as num).toDouble(),
      lals: (json['lals'] as num).toDouble(),
    );

Map<String, dynamic> _$VolumeTransferredRecordModelToJson(
        VolumeTransferredRecordModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'chargeId': instance.chargeId,
      'washId': instance.washId,
      'volume': instance.volume,
      'lals': instance.lals,
    };
