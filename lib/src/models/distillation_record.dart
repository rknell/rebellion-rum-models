import 'package:json_annotation/json_annotation.dart';

part 'distillation_record.g.dart';

@JsonSerializable()
class DistillationRecord {
  @JsonKey(name: '_id')
  final String id;
  final String stillUsed;
  final double feintsAdded;
  final double lalsCharged;
  final List<Note> notes;
  final double totalLALsCharged;
  final double totalLALsYield;

  const DistillationRecord({
    required this.id,
    required this.stillUsed,
    required this.feintsAdded,
    required this.lalsCharged,
    required this.notes,
    required this.totalLALsCharged,
    required this.totalLALsYield,
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
