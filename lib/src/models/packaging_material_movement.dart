import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/packaging_material_definition.dart';

part 'packaging_material_movement.g.dart';

enum PackagingMaterialMovementType {
  purchase,
  bottleReturn,
  packagingRunConsumption,
  labelStocktake,
  stocktake,
  adjustment,
}

@JsonSerializable()
class PackagingMaterialMovementModel extends DatabaseSerializable {
  @ObjectIdConverter()
  ObjectId materialDefinitionId;
  PackagingMaterialType materialType;
  double quantityDelta;
  PackagingMaterialMovementType movementType;
  String sourceSystem;
  String sourceDocumentType;
  String sourceDocumentId;
  String idempotencyKey;
  String? note;
  String? actor;

  @JsonKey(
    name: 'timestamp',
    includeIfNull: false,
    fromJson: jsonToNullableDateTime,
    toJson: dateTimeToJsonNullable,
  )
  dynamic _timestamp;

  @JsonKey(
    name: 'createdAt',
    includeIfNull: false,
    fromJson: jsonToNullableDateTime,
    toJson: dateTimeToJsonNullable,
  )
  dynamic _createdAt;

  DateTime get timestamp =>
      jsonToNullableDateTime(_timestamp) ?? id.dateTime.toUtc();
  set timestamp(DateTime value) {
    _timestamp = value.toUtc();
  }

  DateTime get createdAt => jsonToNullableDateTime(_createdAt) ?? timestamp;
  set createdAt(DateTime value) {
    _createdAt = value.toUtc();
  }

  PackagingMaterialMovementModel({
    super.id,
    required this.materialDefinitionId,
    required this.materialType,
    required this.quantityDelta,
    required this.movementType,
    required this.sourceSystem,
    required this.sourceDocumentType,
    required this.sourceDocumentId,
    required this.idempotencyKey,
    this.note,
    this.actor,
    dynamic timestamp,
    dynamic createdAt,
  })  : _timestamp = timestamp is DateTime ? timestamp.toUtc() : timestamp,
        _createdAt = createdAt is DateTime ? createdAt.toUtc() : createdAt;

  factory PackagingMaterialMovementModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PackagingMaterialMovementModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PackagingMaterialMovementModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'materialDefinitionId'};

  @override
  Set<String> get databaseDateTimeFields => {'timestamp', 'createdAt'};
}
