import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

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

  /// Remaining LALs in the vessel
  double remainingLALs;

  BulkStorageVesselModel({
    ObjectId? id,
    required this.barcode,
    required this.name,
    required this.capacity,
    required this.remainingLALs,
  }) : id = id ?? ObjectId();

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
