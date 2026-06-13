import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'mailing_archive_batch.g.dart';

@JsonSerializable()
class MailingArchiveBatchModel extends DatabaseSerializable {
  String batchId;
  String listKey;
  String listName;
  DateTime archivedAt;
  String reason;
  int memberCount;

  MailingArchiveBatchModel({
    super.id,
    required this.batchId,
    required this.listKey,
    required this.listName,
    DateTime? archivedAt,
    this.reason = 'clear-list',
    this.memberCount = 0,
  }) : archivedAt = archivedAt ?? DateTime.now();

  factory MailingArchiveBatchModel.fromJson(Map<String, dynamic> json) =>
      _$MailingArchiveBatchModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailingArchiveBatchModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
