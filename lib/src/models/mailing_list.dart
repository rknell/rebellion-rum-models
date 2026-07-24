import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'mailing_list.g.dart';

@JsonSerializable()
class MailingListModel extends DatabaseSerializable {
  String key;
  String name;
  String type;
  String storefrontId;
  String? productBarcode;
  String? productName;
  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime createdAt;
  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime updatedAt;

  MailingListModel({
    super.id,
    required this.key,
    required this.name,
    this.type = 'custom',
    this.storefrontId = 'rebellion',
    this.productBarcode,
    this.productName,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = (createdAt ?? DateTime.now()).toUtc(),
        updatedAt = (updatedAt ?? DateTime.now()).toUtc();

  factory MailingListModel.fromJson(Map<String, dynamic> json) =>
      _$MailingListModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MailingListModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Set<String> get databaseDateTimeFields => {'createdAt', 'updatedAt'};
}
