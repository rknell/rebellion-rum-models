import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';
import 'package:rebellion_rum_models/src/models/bulk_storage_vessel_status.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
@JsonSerializable()
class BulkStorageVesselModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Unique identifier for the vessel
  String barcode;

  /// Name of the vessel
  String? name;

  /// Total capacity of the vessel in liters
  double capacity;

  /// Current contents LALs calculation
  AlcocalcLalsCalculation? currentContents;

  /// Status of the vessel
  @JsonKey(defaultValue: BulkStorageVesselStatus.active)
  BulkStorageVesselStatus status;

  /// Reference to the product currently in the vessel
  @JsonKey(name: 'productId')
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Whether the vessel needs a stocktake before operations
  @JsonKey(defaultValue: false)
  bool needsStocktake;

  BulkStorageVesselModel({
    ObjectId? id,
    required this.barcode,
    required this.name,
    required this.capacity,
    this.currentContents,
    this.status = BulkStorageVesselStatus.active,
    this.productId,
    this.needsStocktake = false,
  }) : id = id ?? ObjectId();

  /// Get the remaining LALs in the vessel
  double get remainingLALs => currentContents?.lals ?? 0;

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'productId'};
}
