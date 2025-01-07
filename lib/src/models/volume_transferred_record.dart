import 'package:json_annotation/json_annotation.dart';

part 'volume_transferred_record.g.dart';

@JsonSerializable()
class VolumeTransferredRecord {
  @JsonKey(name: '_id')
  final String id;
  final String chargeId;
  final String washId;
  final double volume;
  final double lals;

  const VolumeTransferredRecord({
    required this.id,
    required this.chargeId,
    required this.washId,
    required this.volume,
    required this.lals,
  });

  factory VolumeTransferredRecord.fromJson(Map<String, dynamic> json) =>
      _$VolumeTransferredRecordFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeTransferredRecordToJson(this);
}
