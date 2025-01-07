import 'package:json_annotation/json_annotation.dart';
import 'customer.dart';

part 'order.g.dart';

/// Represents a customer order in the system.
///
/// An order contains customer information, ordered items, payment details,
/// and tracking information. Orders are used to track customer purchases
/// from placement through to fulfillment.
///
/// Example:
/// ```dart
/// final order = Order(
///   id: '123',
///   customer: Customer(...),
///   date: DateTime.now(),
///   items: {'PRODUCT-001': 2, 'PRODUCT-002': 1},
///   orderNumber: 'ORD-2024-001',
///   paymentMethod: 'credit_card',
///   totalQuote: 149.99,
/// );
/// ```
@JsonSerializable()
class Order {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Customer who placed the order
  final Customer customer;

  /// When the order was placed
  final DateTime date;

  /// Map of product IDs to quantities ordered
  /// Key: Product ID, Value: Quantity
  final Map<String, int> items;

  /// Human-readable order reference number
  final String orderNumber;

  /// Method used for payment (e.g., 'credit_card', 'paypal')
  final String paymentMethod;

  /// Total quoted price for the order
  final double totalQuote;

  const Order({
    required this.id,
    required this.customer,
    required this.date,
    required this.items,
    required this.orderNumber,
    required this.paymentMethod,
    required this.totalQuote,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
