import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'mailing_contact.g.dart';

@JsonSerializable()
class MailingContactModel extends DatabaseSerializable {
  String? email;
  String? phone;
  String normalizedEmail;
  String normalizedPhone;
  String displayContact;
  String storefrontId;
  String source;
  DateTime createdAt;
  DateTime updatedAt;
  bool globalEmailOptOut;
  bool globalSmsOptOut;
  DateTime? globalOptOutAt;

  MailingContactModel({
    super.id,
    this.email,
    this.phone,
    required this.normalizedEmail,
    required this.normalizedPhone,
    required this.displayContact,
    this.storefrontId = 'rebellion',
    this.source = 'unknown',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.globalEmailOptOut = false,
    this.globalSmsOptOut = false,
    this.globalOptOutAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory MailingContactModel.fromJson(Map<String, dynamic> json) =>
      _$MailingContactModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailingContactModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
