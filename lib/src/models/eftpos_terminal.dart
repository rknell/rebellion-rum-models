import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'eftpos_terminal.g.dart';

@JsonSerializable()
class EftposTerminalModel extends DatabaseSerializable {
  final String name;
  final String secret;
  final DateTime createdAt;
  final DateTime lastUsed;

  EftposTerminalModel({
    super.id,
    required this.name,
    required this.secret,
    DateTime? createdAt,
    DateTime? lastUsed,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastUsed = lastUsed ?? DateTime.now();

  factory EftposTerminalModel.fromJson(Map<String, dynamic> json) =>
      _$EftposTerminalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EftposTerminalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
