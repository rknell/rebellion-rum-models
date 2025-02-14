import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

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
class SaleItemModel with DatabaseSerializable {
  /// Product description as shown on receipt
  String description;

  /// Unit price at time of sale
  double price;

  /// Reference to the product ID
  String itemId;

  /// Quantity sold
  int qty;

  SaleItemModel({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
  });

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);

  // No need to override objectIdFields since this model has no ObjectId fields
}
