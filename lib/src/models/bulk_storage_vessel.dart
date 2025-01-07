import 'package:json_annotation/json_annotation.dart';

part 'bulk_storage_vessel.g.dart';

@JsonSerializable()
class BulkStorageVessel {
  @JsonKey(name: '_id')
  final String id;
  final String barcode;
  final String? name;
  final double capacity;
  final double remainingLALs;

  const BulkStorageVessel({
    required this.id,
    required this.barcode,
    this.name,
    required this.capacity,
    required this.remainingLALs,
  });

  factory BulkStorageVessel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselToJson(this);
}
