import 'package:json_annotation/json_annotation.dart';

part 'fermentation_record.g.dart';

/// Represents a record of a fermentation batch in the production process.
///
/// Each fermentation record tracks the details of a single fermentation batch,
/// including ingredients, measurements, and timing information. This data is
/// crucial for quality control and regulatory compliance.
///
/// Example:
/// ```dart
/// final record = FermentationRecord(
///   id: '123',
///   date: DateTime.now(),
///   fermentationVessel: 'FV-01',
///   startingGravity: 1.080,
///   finalGravity: 1.010,
///   temperature: 25.5,
///   duration: 72,
/// );
/// ```
@JsonSerializable()
class FermentationRecord {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Batch number for this fermentation
  final int batchNumber;

  /// Type of fermentation (e.g., "sugar")
  final String type;

  /// Volume of wash in liters
  final double washVolume;

  /// Barcode identifier of the fermentation vessel
  final String vesselBarcode;

  /// Starting specific gravity
  final double sgStart;

  /// Final specific gravity
  final double sgEnd;

  /// Progress measurements during fermentation
  final List<FermentationProgress> fermentationProgress;

  /// Notes and observations
  final String notes;

  const FermentationRecord({
    required this.id,
    required this.batchNumber,
    required this.type,
    required this.washVolume,
    required this.vesselBarcode,
    required this.sgStart,
    required this.sgEnd,
    this.fermentationProgress = const [],
    this.notes = '',
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
