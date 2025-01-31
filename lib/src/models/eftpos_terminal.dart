import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../json_helpers.dart';

part 'eftpos_terminal.g.dart';

@JsonSerializable()
class EftposTerminalModel {
  @ObjectIdConverter()
  @JsonKey(name: '_id')
  final ObjectId id;
  final String name;
  final String secret;
  final DateTime createdAt;
  final DateTime lastUsed;

  EftposTerminalModel({
    ObjectId? id,
    required this.name,
    required this.secret,
    DateTime? createdAt,
    DateTime? lastUsed,
  })  : id = id ?? ObjectId(),
        createdAt = createdAt ?? DateTime.now(),
        lastUsed = lastUsed ?? DateTime.now();

  factory EftposTerminalModel.fromJson(Map<String, dynamic> json) =>
      _$EftposTerminalModelFromJson(json);

  Map<String, dynamic> toJson() => _$EftposTerminalModelToJson(this);
}
