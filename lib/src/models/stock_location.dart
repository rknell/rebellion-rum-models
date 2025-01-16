import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_location.g.dart';

/// Represents a physical storage location for stock items.
///
/// Stock locations are used to track where products and materials are stored
/// within the facility. Each location has a unique identifier and specific flags
/// indicating its type and purpose.
@JsonSerializable()
class StockLocationModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Human-readable name for the location
  String name;

  /// Unique barcode identifier for the location
  String barcode;

  /// Indicates if this is a bond store location
  bool isBondStore;

  /// Indicates if this is a retail location
  bool isRetail;

  /// Indicates if stock in this location is available for online sales
  bool isAvailableOnline;

  /// Indicates if this is a warehouse location
  bool isWarehouse;

  /// Optional map of product barcodes to their stock levels
  Map<String, double>? stockLevels;

  StockLocationModel({
    ObjectId? id,
    required this.name,
    required this.barcode,
    required this.isBondStore,
    required this.isRetail,
    required this.isAvailableOnline,
    required this.isWarehouse,
    this.stockLevels,
  }) : id = id ?? ObjectId();

  factory StockLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StockLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockLocationModelToJson(this);
}
