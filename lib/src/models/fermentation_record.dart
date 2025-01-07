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

  /// Date when fermentation started
  final DateTime date;

  /// Identifier of the fermentation vessel used
  final String fermentationVessel;

  /// Initial specific gravity reading
  final double startingGravity;

  /// Final specific gravity reading
  final double finalGravity;

  /// Fermentation temperature in Celsius
  final double temperature;

  /// Duration of fermentation in hours
  final int duration;

  /// Notes and observations during fermentation
  final List<String> notes;

  /// Ingredients used in the fermentation
  final Map<String, double> ingredients;

  const FermentationRecord({
    required this.id,
    required this.date,
    required this.fermentationVessel,
    required this.startingGravity,
    required this.finalGravity,
    required this.temperature,
    required this.duration,
    this.notes = const [],
    this.ingredients = const {},
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
