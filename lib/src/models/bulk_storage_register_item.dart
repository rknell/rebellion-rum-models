import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';
import 'package:rebellion_rum_models/src/models/bulk_storage_movement_type.dart';

part 'bulk_storage_register_item.g.dart';

/// Represents an entry in the bulk storage register.
/// Each entry tracks a movement or adjustment of spirits between vessels,
/// to/from packaging, or other operations like stocktake adjustments.
@JsonSerializable(explicitToJson: true)
class BulkStorageRegisterItemModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// LALs calculation for this movement
  @JsonKey(includeIfNull: false)
  final AlcocalcLalsCalculation? lalsCalculation;

  /// Legacy LALs value (used for backward compatibility)
  @JsonKey(name: 'lals')
  final double? legacyLals;

  /// Type of movement
  @JsonKey(defaultValue: BulkStorageMovementType.vesselTransfer)
  final BulkStorageMovementType movementType;

  /// Whether this movement represents destroyed feints
  @JsonKey(defaultValue: false)
  bool feintsDestroyed;

  /// Whether this movement represents wastage
  @JsonKey(defaultValue: false)
  bool wastage;

  /// Optional notes about the movement
  String? notes;

  /// Reference to the source charge (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromChargeId;

  /// Reference to the source vessel (if applicable)
  @JsonKey(name: 'fromVesselId')
  @NullableObjectIdConverter()
  ObjectId? fromVesselId;

  /// Reference to the destination vessel (if applicable)
  @JsonKey(name: 'toVesselId')
  @NullableObjectIdConverter()
  ObjectId? toVesselId;

  /// Reference to the destination charge (if applicable)
  @JsonKey(name: 'toChargeId')
  @NullableObjectIdConverter()
  ObjectId? toChargeId;

  /// Reference to the destination packaging (if applicable)
  @JsonKey(name: 'toPackagingId')
  @NullableObjectIdConverter()
  ObjectId? toPackagingId;

  /// Reference to the source packaging (if applicable)
  @JsonKey(name: 'fromPackagingId')
  @NullableObjectIdConverter()
  ObjectId? fromPackagingId;

  /// Reference to the product being moved
  @JsonKey(name: 'productId')
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Timestamp of when this movement occurred
  @JsonKey(defaultValue: null)
  DateTime? timestamp;

  BulkStorageRegisterItemModel({
    ObjectId? id,
    this.lalsCalculation,
    this.legacyLals,
    this.movementType = BulkStorageMovementType.vesselTransfer,
    this.feintsDestroyed = false,
    this.wastage = false,
    this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
    this.productId,
    DateTime? timestamp,
  })  : assert(lalsCalculation != null || legacyLals != null,
            'Either lalsCalculation or legacyLals must be provided'),
        id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now();

  /// Get the LALs value from either the calculation or legacy field
  double get lals => lalsCalculation?.lals ?? legacyLals!;

  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);
}
