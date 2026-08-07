import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'mailing_list_membership.g.dart';

@JsonSerializable()
class MailingListMembershipModel extends DatabaseSerializable {
  @ObjectIdConverter()
  ObjectId contactId;
  String listKey;
  String status;
  String source;
  String consentType;
  String storefrontId;
  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime createdAt;
  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime updatedAt;
  String? archiveBatchId;
  @JsonKey(fromJson: jsonToNullableDateTime, toJson: dateTimeToJsonNullable)
  DateTime? archivedAt;
  @JsonKey(fromJson: jsonToNullableDateTime, toJson: dateTimeToJsonNullable)
  DateTime? listOptOutAt;

  MailingListMembershipModel({
    super.id,
    required this.contactId,
    required this.listKey,
    this.status = 'active',
    this.source = 'unknown',
    this.consentType = 'express',
    this.storefrontId = 'rebellion',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.archiveBatchId,
    this.archivedAt,
    this.listOptOutAt,
  })  : createdAt = (createdAt ?? DateTime.now()).toUtc(),
        updatedAt = (updatedAt ?? DateTime.now()).toUtc();

  factory MailingListMembershipModel.fromJson(Map<String, dynamic> json) =>
      _$MailingListMembershipModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailingListMembershipModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'contactId'};

  @override
  Set<String> get databaseDateTimeFields => {
        'createdAt',
        'updatedAt',
        'archivedAt',
        'listOptOutAt',
      };
}
