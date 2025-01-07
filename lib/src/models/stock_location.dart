import 'package:json_annotation/json_annotation.dart';

part 'stock_location.g.dart';

/// Represents a physical storage location for stock items.
///
/// Stock locations are used to track where products and materials are stored
/// within the facility. Each location has a unique identifier and can contain
/// information about its capacity and current contents.
///
/// Example:
/// ```dart
/// final location = StockLocation(
///   id: '123',
///   name: 'Warehouse A',
///   barcode: 'LOC-001',
///   type: 'warehouse',
///   capacity: 1000,
///   currentStock: 750,
/// );
/// ```
@JsonSerializable()
class StockLocation {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Human-readable name for the location
  final String name;

  /// Unique barcode identifier for the location
  final String barcode;

  /// Type of storage location (e.g., 'warehouse', 'shelf', 'bin')
  final String type;

  /// Maximum storage capacity (units vary by type)
  final int capacity;

  /// Current quantity of items stored
  final int currentStock;

  const StockLocation({
    required this.id,
    required this.name,
    required this.barcode,
    required this.type,
    required this.capacity,
    required this.currentStock,
  });

  factory StockLocation.fromJson(Map<String, dynamic> json) =>
      _$StockLocationFromJson(json);
  Map<String, dynamic> toJson() => _$StockLocationToJson(this);
}
