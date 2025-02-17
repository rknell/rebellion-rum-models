import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
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

  /// Current LALs in the vessel
  @JsonKey(defaultValue: 0)
  double currentLals;

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
    String? name,
    required this.capacity,
    this.currentLals = 0,
    this.status = BulkStorageVesselStatus.active,
    this.productId,
    this.needsStocktake = false,
  })  : id = id ?? ObjectId(),
        _name = name;

  /// Get the remaining LALs in the vessel
  double get remainingLALs => currentLals;

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'productId'};
}
