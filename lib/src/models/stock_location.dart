import 'package:json_annotation/json_annotation.dart';

part 'stock_location.g.dart';

/// Represents a physical storage location for stock items.
///
/// Stock locations are used to track where products and materials are stored
/// within the facility. Each location has a unique identifier and specific flags
/// indicating its type and purpose.
@JsonSerializable()
class StockLocation {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Human-readable name for the location
  final String name;

  /// Unique barcode identifier for the location
  final String barcode;

  /// Indicates if this is a bond store location
  final bool isBondStore;

  /// Indicates if this is a retail location
  final bool isRetail;

  /// Indicates if stock in this location is available for online sales
  final bool isAvailableOnline;

  /// Indicates if this is a warehouse location
  final bool isWarehouse;

  /// Optional map of product barcodes to their stock levels
  final Map<String, double>? stockLevels;

  const StockLocation({
    required this.id,
    required this.name,
    required this.barcode,
    required this.isBondStore,
    required this.isRetail,
    required this.isAvailableOnline,
    required this.isWarehouse,
    this.stockLevels,
  });

  factory StockLocation.fromJson(Map<String, dynamic> json) =>
      _$StockLocationFromJson(json);
  Map<String, dynamic> toJson() => _$StockLocationToJson(this);
}
