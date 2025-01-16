import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'fermentation_record.g.dart';

/// Represents a record of a fermentation batch in the production process.
///
/// Each fermentation record tracks the details of a single fermentation batch,
/// including ingredients, measurements, and timing information. This data is
/// crucial for quality control and regulatory compliance.
///
/// Example:
/// ```dart
/// final record = FermentationRecordModel(
///   id: '123',
///   batchNumber: 1,
///   type: 'sugar',
///   washVolume: 10.0,
///   vesselBarcode: 'FV-01',
///   sgStart: 1.080,
///   sgEnd: 1.010,
/// );
/// ```
@JsonSerializable()
class FermentationRecordModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
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
  final List<FermentationProgressModel> fermentationProgress;

  /// Notes and observations
  final String notes;

  const FermentationRecordModel({
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

  factory FermentationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationRecordModelToJson(this);
}

@JsonSerializable()
class FermentationProgressModel {
  final double sg;
  final double? ph;
  final double? temp;
  final DateTime timestamp;
  final String notes;

  const FermentationProgressModel({
    required this.sg,
    this.ph,
    this.temp,
    required this.timestamp,
    required this.notes,
  });

  factory FermentationProgressModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationProgressModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationProgressModelToJson(this);
}
