import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'mailing_send.g.dart';

@JsonSerializable()
class MailingSendModel extends DatabaseSerializable {
  String listKey;
  String? archiveBatchId;
  String subject;
  String htmlBody;
  String textBody;
  String? smsBody;
  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime sentAt;
  int emailedCount;
  int skippedPhoneOnlyCount;
  int suppressedGlobalCount;
  int suppressedListCount;
  List<String> skippedPhones;

  MailingSendModel({
    super.id,
    required this.listKey,
    this.archiveBatchId,
    required this.subject,
    required this.htmlBody,
    required this.textBody,
    this.smsBody,
    DateTime? sentAt,
    this.emailedCount = 0,
    this.skippedPhoneOnlyCount = 0,
    this.suppressedGlobalCount = 0,
    this.suppressedListCount = 0,
    List<String>? skippedPhones,
  }) : sentAt = sentAt ?? DateTime.now(),
       skippedPhones = skippedPhones ?? <String>[];

  factory MailingSendModel.fromJson(Map<String, dynamic> json) =>
      _$MailingSendModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailingSendModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Set<String> get databaseDateTimeFields => {'sentAt'};
}
