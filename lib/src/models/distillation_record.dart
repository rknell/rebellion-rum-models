import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'distillation_record.g.dart';

/// Status of a distillation record
enum DistillationStatus {
  /// Record is being created/edited
  inProgress,

  /// Distillation is complete
  completed,

  /// Record has been archived
  archived
}

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
/// The record's ObjectId serves as the charge number, using its timestamp for sequential tracking.
@JsonSerializable()
class DistillationRecordModel extends DatabaseSerializable {
  /// The still used for this distillation run
  String stillUsed;

  /// Start time of the distillation
  final DateTime startTime;

  /// Current status of the distillation record
  @JsonKey(defaultValue: DistillationStatus.inProgress)
  final DistillationStatus status;

  /// Amount of feints added during the run
  double feintsAdded;

  /// Amount of LALs charged during the run
  double lalsCharged;

  /// Total LALs charged for this run (including all inputs)
  double totalLALsCharged;

  /// Total LALs yield from this run (sum of all outputs)
  double totalLALsYield;

  /// Notes taken during the distillation process
  final List<NoteModel> notes;

  DistillationRecordModel({
    super.id,
    this.stillUsed = '',
    DateTime? startTime,
    this.status = DistillationStatus.inProgress,
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : startTime = startTime ?? DateTime.now(),
        notes = notes ?? [];

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistillationRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'notes': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'notes': NoteModel.fromJson,
      };
}

/// Represents a note in the distillation process
@JsonSerializable()
class NoteModel {
  String content;
  final DateTime date;
  final bool isSystem;

  NoteModel({
    required this.content,
    required this.date,
    this.isSystem = false,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
