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
    };

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for VolumeTransferredRecordModel
extension VolumeTransferredRecordModelObjectIdFields
    on VolumeTransferredRecordModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
        'chargeId',
        'washId',
      };
}
