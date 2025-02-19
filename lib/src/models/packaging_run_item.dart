import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'packaging_run_item.g.dart';

/// Status of a packaging run
/// Note: Introduced in v2.0.0 replacing string-based exciseReturn field
/// Migration path:
/// - Previous exciseReturn="": maps to inProgress
/// - Previous exciseReturn="W12345": maps to complete
/// - Previous exciseReturn=null: maps to inProgress
/// - All other values map to awaitingExcise
enum PackagingRunStatus {
  /// Run is in progress
  inProgress,

  /// Run is complete but awaiting excise return
  awaitingExcise,

  /// Run is complete with excise return
  complete
}

@JsonSerializable()
class PackagingRunItemModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String productBarcode;
  double unitSize;
  double strength;
  double unitsPackaged;
  double packagingLosses;
  double remaining;
  double volumeAvailable;
  double volumeRemaining;

  /// Default value of inProgress aligns with the migration path where both
  /// empty strings and null values in the legacy exciseReturn field map to inProgress,
  /// making it the most appropriate default for new records and migration cases.
  @JsonKey(
      defaultValue: PackagingRunStatus.inProgress,
      unknownEnumValue: PackagingRunStatus.inProgress)
  PackagingRunStatus status;

  @NullableObjectIdConverter()
  ObjectId? exciseReturn;

  PackagingRunItemModel({
    ObjectId? id,
    required this.productBarcode,
    required this.unitSize,
    required this.strength,
    required this.unitsPackaged,
    required this.packagingLosses,
    required this.remaining,
    required this.volumeAvailable,
    required this.volumeRemaining,
    required this.status,
    this.exciseReturn,
  }) : id = id ?? ObjectId();

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
