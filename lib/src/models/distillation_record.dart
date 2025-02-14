import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'distillation_record.g.dart';

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
@JsonSerializable()
class DistillationRecordModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// The still used for this distillation run
  String stillUsed;

  /// Amount of feints added during the run
  double feintsAdded;

  /// Amount of LALs charged during the run
  double lalsCharged;

  /// Total LALs charged for this run
  double totalLALsCharged;

  /// Total LALs yield from this run
  double totalLALsYield;

  /// Notes taken during the distillation process
  final List<NoteModel> notes;

  DistillationRecordModel({
    ObjectId? id,
    this.stillUsed = '',
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : id = id ?? ObjectId(),
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

@JsonSerializable()
class NoteModel with DatabaseSerializable {
  String content;
  final DateTime date;

  NoteModel({
    required this.content,
    required this.date,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}
