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
class BulkStorageRegisterItemModel extends DatabaseSerializable {
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
    if (fromDistillationId != null) {
      if (toVesselId != null) return BulkStorageMovementType.fromStill;
      // If no destination and feints destroyed, it's still feints destroyed
      if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    }

    if (fromVesselId != null) {
      if (toDistillationId != null) return BulkStorageMovementType.toStill;
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
  @JsonKey(name: 'fromChargeId')
  ObjectId? fromDistillationId;

  /// Reference to the source vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromVesselId;

  /// Reference to the destination vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toVesselId;

  /// Reference to the destination charge (if applicable)
  @NullableObjectIdConverter()
  @JsonKey(name: 'toChargeId')
  ObjectId? toDistillationId;

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
  DateTime get timestamp => id.dateTime.toUtc();

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
    super.id,
    this.lalsCalculation,
    this.legacyLals,
    this.feintsDestroyed = false,
    this.wastage = false,
    this.isStocktake = false,
    this.notes,
    this.fromDistillationId,
    this.fromVesselId,
    this.toVesselId,
    this.toDistillationId,
    this.toPackagingId,
    this.fromPackagingId,
    this.productId,
  }) : assert(lalsCalculation != null || legacyLals != null,
            'Either lalsCalculation or legacyLals must be provided');

  /// Get the LALs value from either the calculation or legacy field
  /// If lalsCalculation exists, use its value
  /// Otherwise fall back to legacyLals if it exists and is greater than 0
  /// If neither exists, return 0
  double get lals {
    final calculation = lalsCalculation;
    if (calculation != null) return calculation.lals;
    final legacy = legacyLals;
    if (legacy != null && legacy > 0) return legacy;
    return 0;
  }

  /// Reads incomplete historical calculations using the recorded legacy LALs.
  /// Never invent measurements or silently discard an unquantifiable movement.
  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) {
    final rawCalculation = json['lalsCalculation'];
    final legacy = json['lals'];
    final hasLegacy = legacy is num && legacy.isFinite && legacy >= 0;
    Map<String, dynamic> normalized = json;
    try {
      if (rawCalculation != null) {
        if (rawCalculation is! Map<String, dynamic>) {
          throw const FormatException('lalsCalculation must be an object');
        }
        AlcocalcLalsCalculation.fromJson(rawCalculation);
      } else if (legacy is! num || !legacy.isFinite) {
        // Historical signed legacy entries retain their existing getter semantics.
        throw const FormatException('No usable calculation or legacy lals');
      }
    } on FormatException catch (error) {
      if (!hasLegacy) {
        throw FormatException(
          'Bulk storage register entry ${json['_id'] ?? '(unknown id)'}: '
          '${error.message}; repair the recorded measurements or legacy lals',
        );
      }
      normalized = {...json, 'lalsCalculation': null};
    }
    return _$BulkStorageRegisterItemModelFromJson(normalized);
  }
  @override
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);
}
