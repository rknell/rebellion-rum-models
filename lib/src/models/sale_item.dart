import 'package:json_annotation/json_annotation.dart';

part 'sale_item.g.dart';

/// Represents an individual item line in a sale.
///
/// Each SaleItem captures the essential information about a product
/// that was sold, including its description, price, and quantity.
///
/// Example:
/// ```dart
/// final item = SaleItem(
///   description: 'Premium Dark Rum 750ml',
///   price: 49.99,
///   itemId: 'PROD-001',
///   qty: 2,
/// );
/// ```
@JsonSerializable()
class SaleItem {
  /// Product description as shown on receipt
  final String description;

  /// Unit price at time of sale
  final double price;

  /// Reference to the product ID
  final String itemId;

  /// Quantity sold
  final int qty;

  const SaleItem({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) =>
      _$SaleItemFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemToJson(this);
}
