import 'package:json_annotation/json_annotation.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
@JsonSerializable()
class BulkStorageVessel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Unique identifier for the vessel
  final String barcode;

  /// Name of the vessel
  final String? name;

  /// Total capacity of the vessel in liters
  final double capacity;

  /// Remaining LALs in the vessel
  final double remainingLALs;

  const BulkStorageVessel({
    required this.id,
    required this.barcode,
    required this.name,
    required this.capacity,
    required this.remainingLALs,
  });

  factory BulkStorageVessel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselToJson(this);
}
