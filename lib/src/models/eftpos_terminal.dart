import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:uuid/uuid.dart';
import '../json_helpers.dart';

part 'eftpos_terminal.g.dart';

@JsonSerializable()
class EftposTerminalModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  final String name;
  final String secret;
  final String posId;
  final DateTime createdAt;
  final DateTime lastUsed;

  EftposTerminalModel({
    ObjectId? id,
    required this.name,
    required this.secret,
    String? posId,
    DateTime? createdAt,
    DateTime? lastUsed,
  })  : id = id ?? ObjectId(),
        posId = posId ?? _generatePosId(),
        createdAt = createdAt ?? DateTime.now(),
        lastUsed = lastUsed ?? DateTime.now();

  factory EftposTerminalModel.fromJson(Map<String, dynamic> json) {
    // Handle MongoDB's native ObjectId format
    if (json['_id'] is ObjectId) {
      json = Map<String, dynamic>.from(json);
      json['_id'] = (json['_id'] as ObjectId).oid;
    }
    return _$EftposTerminalModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EftposTerminalModelToJson(this);

  static String _generatePosId() {
    return const Uuid().v4();
  }
}
