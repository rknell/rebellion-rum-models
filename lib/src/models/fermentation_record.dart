import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'fermentation_record.g.dart';

enum FermentationType { molasses, caneSugar, grape, grain, mixed, other }

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
///   type: FermentationType.molasses,
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
  final ObjectId id;

  /// Batch number for this fermentation
  int batchNumber;

  /// Type of fermentation (e.g., molasses, cane juice, mixed)
  FermentationType type;

  /// Volume of wash in liters
  double washVolume;

  /// Barcode identifier of the fermentation vessel
  String vesselBarcode;

  /// Starting specific gravity
  double sgStart;

  /// Final specific gravity
  double sgEnd;

  /// Progress measurements during fermentation
  List<FermentationProgressModel> fermentationProgress;

  /// Notes and observations
  String notes;

  FermentationRecordModel({
    ObjectId? id,
    required this.batchNumber,
    required this.type,
    required this.washVolume,
    required this.vesselBarcode,
    required this.sgStart,
    required this.sgEnd,
    List<FermentationProgressModel>? fermentationProgress,
    this.notes = '',
  })  : id = id ?? ObjectId(),
        fermentationProgress = fermentationProgress ?? [];

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
