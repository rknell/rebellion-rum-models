import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'distillation_record.g.dart';

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
@JsonSerializable()
class DistillationRecordModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
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
  final List<NoteModel> notes;

  const DistillationRecordModel({
    required this.id,
    required this.stillUsed,
    required this.feintsAdded,
    required this.lalsCharged,
    required this.totalLALsCharged,
    required this.totalLALsYield,
    required this.notes,
  });

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistillationRecordModelToJson(this);
}

@JsonSerializable()
class NoteModel {
  final String content;
  final DateTime date;

  const NoteModel({
    required this.content,
    required this.date,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
