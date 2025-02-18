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

  /// Whether this movement represents a stocktake adjustment
  bool isStocktake;

  /// Type of movement

  /// Calculates the movement type based on the source and destination fields
  BulkStorageMovementType get movementType {
    // Handle explicit cases first
    if (isStocktake) return BulkStorageMovementType.stocktake;
    if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    if (wastage) return BulkStorageMovementType.wastage;

    // Handle vessel/charge/packaging transfers
    if (fromChargeId != null) {
      if (toVesselId != null) return BulkStorageMovementType.fromStill;
      // If no destination and feints destroyed, it's still feints destroyed
      if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    }

    if (fromVesselId != null) {
      if (toChargeId != null) return BulkStorageMovementType.toStill;
      if (toPackagingId != null) return BulkStorageMovementType.toPackaging;
      if (toVesselId != null) return BulkStorageMovementType.vesselTransfer;
    }

    return BulkStorageMovementType.unknown;
  }

  /// Whether this movement represents destroyed feints
  bool feintsDestroyed;

  /// Whether this movement represents wastage
  bool wastage;

  /// Optional notes about the movement
  String? notes;

  /// Reference to the source charge (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromChargeId;

  /// Reference to the source vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromVesselId;

  /// Reference to the destination vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toVesselId;

  /// Reference to the destination charge (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toChargeId;

  /// Reference to the destination packaging (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toPackagingId;

  /// Reference to the source packaging (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromPackagingId;

  /// Reference to the product being moved
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Timestamp extracted from the document's ObjectId
  DateTime get timestamp => id.dateTime;

  @override
  Set<String> get objectIdFields => {
        '_id',
        'fromChargeId',
        'fromPackagingId',
        'fromVesselId',
        'productId',
        'toChargeId',
        'toPackagingId',
        'toVesselId',
      };

  BulkStorageRegisterItemModel({
    ObjectId? id,
    this.lalsCalculation,
    this.legacyLals,
    this.feintsDestroyed = false,
    this.wastage = false,
    this.isStocktake = false,
    this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
    this.productId,
  })  : assert(lalsCalculation != null || legacyLals != null,
            'Either lalsCalculation or legacyLals must be provided'),
        id = id ?? ObjectId();

  /// Get the LALs value from either the calculation or legacy field
  /// If lalsCalculation exists, use its value
  /// Otherwise fall back to legacyLals if it exists and is greater than 0
  /// If neither exists, return 0
  double get lals {
    if (lalsCalculation != null) {
      return lalsCalculation!.lals;
    }
    if (legacyLals != null && legacyLals! > 0) {
      return legacyLals!;
    }
    return 0;
  }

  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);
}
