import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/bulk_storage_vessel_status.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
@JsonSerializable()
class BulkStorageVesselModel extends DatabaseSerializable {
  /// Unique identifier for the vessel
  String barcode;

  /// Name of the vessel
  @JsonKey(name: 'name')
  String? _name;

  /// Gets the name of the vessel, falling back to barcode if no name is set
  String get name {
    var setName = _name;
    if (setName != null && setName.isNotEmpty) {
      return setName;
    } else {
      return barcode;
    }
  }

  /// Sets the name of the vessel
  set name(String? value) => _name = value;

  /// Total capacity of the vessel in liters
  double capacity;

  /// Current LALs in the vessel, this is a cached calculation based on adding
  /// up the records in BulkStorageRegisterItem
  double currentLals;

  /// Status of the vessel
  BulkStorageVesselStatus status;

  /// Reference to the product currently in the vessel
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Whether the vessel needs a stocktake before operations
  bool needsStocktake;

  BulkStorageVesselModel({
    super.id,
    this.barcode = '',
    String? name,
    this.capacity = 0,
    this.currentLals = 0,
    this.status = BulkStorageVesselStatus.active,
    this.productId,
    this.needsStocktake = false,
  }) : _name = name;

  /// Get the remaining LALs in the vessel
  double get remainingLALs => currentLals;

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'productId'};
}
