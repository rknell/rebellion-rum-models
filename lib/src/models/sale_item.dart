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
  final String description;

  /// Unit price at time of sale
  final double price;

  /// Reference to the product ID
  final String itemId;

  /// Quantity sold
  final int qty;

  const SaleItemModel({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
  });

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);
}
