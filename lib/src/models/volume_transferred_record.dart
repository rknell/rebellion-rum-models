import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'volume_transferred_record.g.dart';

@JsonSerializable()
class VolumeTransferredRecordModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  @ObjectIdConverter()
  ObjectId chargeId;

  @ObjectIdConverter()
  ObjectId washId;
  double volume;
  double lals;

  VolumeTransferredRecordModel({
    ObjectId? id,
    required this.chargeId,
    required this.washId,
    required this.volume,
    required this.lals,
  }) : id = id ?? ObjectId();

  factory VolumeTransferredRecordModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeTransferredRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeTransferredRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'chargeId', 'washId'};
}
