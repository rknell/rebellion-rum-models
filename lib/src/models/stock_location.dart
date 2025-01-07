import 'package:json_annotation/json_annotation.dart';

part 'stock_location.g.dart';

@JsonSerializable()
class StockLocation {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String barcode;
  final bool isBondStore;
  final bool isRetail;
  final bool isAvailableOnline;
  final bool isWarehouse;
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
