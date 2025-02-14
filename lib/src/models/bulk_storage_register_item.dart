import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'bulk_storage_register_item.g.dart';

@JsonSerializable()
class BulkStorageRegisterItemModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  double lals;
  bool feintsDestroyed;
  bool wastage;
  String notes;
  String? fromChargeId;
  String? fromVesselId;
  String? toVesselId;
  String? toChargeId;
  String? toPackagingId;
  String? fromPackagingId;

  BulkStorageRegisterItemModel({
    ObjectId? id,
    required this.lals,
    required this.feintsDestroyed,
    required this.wastage,
    required this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
  }) : id = id ?? ObjectId();

  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
