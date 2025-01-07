import 'package:json_annotation/json_annotation.dart';

part 'fermentation_record.g.dart';

@JsonSerializable()
class FermentationRecord {
  @JsonKey(name: '_id')
  final String id;
  final int batchNumber;
  final String type;
  final double washVolume;
  final String vesselBarcode;
  final double sgStart;
  final double sgEnd;
  @JsonKey(defaultValue: [])
  final List<FermentationProgress> fermentationProgress;
  final String notes;

  const FermentationRecord({
    required this.id,
    required this.batchNumber,
    required this.type,
    required this.washVolume,
    required this.vesselBarcode,
    required this.sgStart,
    required this.sgEnd,
    required this.fermentationProgress,
    required this.notes,
  });

  factory FermentationRecord.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationRecordToJson(this);
}

@JsonSerializable()
class FermentationProgress {
  final double sg;
  final double? ph;
  final double? temp;
  final DateTime timestamp;
  final String notes;

  const FermentationProgress({
    required this.sg,
    this.ph,
    this.temp,
    required this.timestamp,
    required this.notes,
  });

  factory FermentationProgress.fromJson(Map<String, dynamic> json) =>
      _$FermentationProgressFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationProgressToJson(this);
}
