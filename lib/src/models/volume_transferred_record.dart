import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'volume_transferred_record.g.dart';

@JsonSerializable()
class VolumeTransferredRecordModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;
  final String chargeId;
  final String washId;
  final double volume;
  final double lals;

  const VolumeTransferredRecordModel({
    required this.id,
    required this.chargeId,
    required this.washId,
    required this.volume,
    required this.lals,
  });

  factory VolumeTransferredRecordModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeTransferredRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeTransferredRecordModelToJson(this);
}
