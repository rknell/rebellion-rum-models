import 'package:json_annotation/json_annotation.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
///
/// Each vessel has a unique identifier, capacity information, and
/// current contents details. These vessels are used for aging and
/// storing spirits before bottling.
///
/// Example:
/// ```dart
/// final vessel = BulkStorageVessel(
///   id: '123',
///   vesselId: 'BSV-001',
///   capacity: 1000.0,
///   currentVolume: 850.5,
///   contents: 'Dark Rum',
///   alcoholContent: 65.5,
/// );
/// ```
@JsonSerializable()
class BulkStorageVessel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Unique identifier for the vessel
  final String vesselId;

  /// Total capacity of the vessel in liters
  final double capacity;

  /// Current volume of liquid in the vessel
  final double currentVolume;

  /// Description of vessel contents
  final String contents;

  /// Current alcohol content of stored liquid (% ABV)
  final double alcoholContent;

  const BulkStorageVessel({
    required this.id,
    required this.vesselId,
    required this.capacity,
    required this.currentVolume,
    required this.contents,
    required this.alcoholContent,
  });

  factory BulkStorageVessel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselToJson(this);
}
