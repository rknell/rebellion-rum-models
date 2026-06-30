import 'package:json_annotation/json_annotation.dart';

part 'sale_item.g.dart';

/// Represents an individual item line in a sale.
///
/// Each SaleItemModel captures the essential information about a product
/// that was sold, including its description, price, and quantity.
///
/// Example:
/// ```dart
/// final item = SaleItemModel(
///   description: 'Premium Dark Rum 750ml',
///   price: 49.99,
///   itemId: 'PROD-001',
///   qty: 2,
/// );
/// ```
@JsonSerializable()
class SaleItemModel {
  /// Product description as shown on receipt
  String description;

  /// Unit price at time of sale
  double price;

  /// Reference to the product ID
  String itemId;

  /// Quantity sold
  int qty;

  /// Product volume in millilitres at the time of sale.
  double? unitVolumeMl;

  /// Product ABV at the time of sale, stored as a decimal (0.37 for 37%).
  double? unitAbv;

  /// Litres of absolute alcohol for one unit at the time of sale.
  double? lalPerUnit;

  /// Total litres of absolute alcohol for this sale line.
  double? totalLals;

  SaleItemModel({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
    this.unitVolumeMl,
    this.unitAbv,
    this.lalPerUnit,
    this.totalLals,
  });

  bool get hasAlcoholSnapshot =>
      (unitVolumeMl ?? 0) > 0 &&
      (unitAbv ?? 0) > 0 &&
      (lalPerUnit ?? 0) > 0 &&
      (totalLals ?? 0) > 0;

  void refreshAlcoholTotals() {
    final perUnit = lalPerUnit;
    if (perUnit == null || perUnit <= 0) {
      totalLals = null;
      return;
    }
    totalLals = perUnit * qty;
  }

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);

  // No need to override objectIdFields since this model has no ObjectId fields
}
