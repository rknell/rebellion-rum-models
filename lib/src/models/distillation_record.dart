import 'package:json_annotation/json_annotation.dart';

part 'distillation_record.g.dart';

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
@JsonSerializable()
class DistillationRecord {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// The still used for this distillation run
  final String stillUsed;

  /// Amount of feints added during the run
  final double feintsAdded;

  /// Amount of LALs charged during the run
  final double lalsCharged;

  /// Total LALs charged for this run
  final double totalLALsCharged;

  /// Total LALs yield from this run
  final double totalLALsYield;

  /// Notes taken during the distillation process
  final List<Note> notes;

  const DistillationRecord({
    required this.id,
    required this.stillUsed,
    required this.feintsAdded,
    required this.lalsCharged,
    required this.totalLALsCharged,
    required this.totalLALsYield,
    required this.notes,
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
