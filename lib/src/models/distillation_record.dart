import 'package:json_annotation/json_annotation.dart';

part 'distillation_record.g.dart';

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including input materials, output volumes, and various measurements taken
/// during the process.
///
/// Example:
/// ```dart
/// final record = DistillationRecord(
///   id: '123',
///   date: DateTime.now(),
///   startTime: '09:00',
///   endTime: '17:00',
///   inputVolume: 1000.0,
///   outputVolume: 250.0,
///   alcoholContent: 65.5,
/// );
/// ```
@JsonSerializable()
class DistillationRecord {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Date of the distillation run
  final DateTime date;

  /// Time when distillation started (24-hour format)
  final String startTime;

  /// Time when distillation ended (24-hour format)
  final String endTime;

  /// Volume of wash input in liters
  final double inputVolume;

  /// Volume of spirit output in liters
  final double outputVolume;

  /// Alcohol content of output spirit (% ABV)
  final double alcoholContent;

  const DistillationRecord({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.inputVolume,
    required this.outputVolume,
    required this.alcoholContent,
  });

  factory DistillationRecord.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordFromJson(json);
  Map<String, dynamic> toJson() => _$DistillationRecordToJson(this);
}

@JsonSerializable()
class Note {
  final String content;
  final DateTime date;

  const Note({
    required this.content,
    required this.date,
  });

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
