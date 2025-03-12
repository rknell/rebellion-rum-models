import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'fermentation_record.g.dart';

/// Represents a fermentation batch record in the production process.
///
/// Each fermentation record tracks the details of a single fermentation batch,
/// including measurements, vessel information, and progress readings.
///
/// Example:
/// ```dart
/// final record = FermentationRecordModel(
///   batchNumber: 123,
///   type: FermentationType.molasses,
///   washVolume: 1000,
///   vesselBarcode: 'FV001',
///   sgStart: 1.080,
///   sgEnd: 1.010,
/// );
/// ```
enum FermentationType {
  /// Fermentation using molasses as primary fermentable
  molasses,

  /// Fermentation using cane sugar as primary fermentable
  caneSugar,

  /// Fermentation using grape as primary fermentable
  grape,

  /// Fermentation using grain as primary fermentable
  grain,

  /// Mixed fermentation using multiple fermentable sources
  mixed,

  /// Other fermentation types
  other
}

@JsonSerializable()
class FermentationRecordModel extends DatabaseSerializable {
  /// Batch number for this fermentation
  int batchNumber;

  /// Type of fermentation (e.g., molasses, cane juice, mixed)
  @JsonKey(unknownEnumValue: FermentationType.other)
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

  /// Recipe details and instructions
  String recipe;

  /// Whether the fermentation is complete (all wash transferred)
  bool completed;

  /// Date when the fermentation was marked as complete
  DateTime? completionDate;

  FermentationRecordModel({
    super.id,
    required this.batchNumber,
    required this.type,
    required this.washVolume,
    required this.vesselBarcode,
    required this.sgStart,
    required this.sgEnd,
    List<FermentationProgressModel>? fermentationProgress,
    this.notes = '',
    this.recipe = '',
    this.completed = false,
    this.completionDate,
  }) : fermentationProgress = fermentationProgress ?? [];

  factory FermentationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'fermentationProgress': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'fermentationProgress': FermentationProgressModel.fromJson,
      };
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
