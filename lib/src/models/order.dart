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
/// final order = OrderModel(
///   id: '123',
///   customer: CustomerModel(...),
///   date: DateTime.now(),
///   items: {'PRODUCT-001': 2, 'PRODUCT-002': 1},
///   orderNumber: 'ORD-2024-001',
///   paymentMethod: 'credit_card',
///   totalQuote: 149.99,
/// );
/// ```
@JsonSerializable()
class OrderModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Customer who placed the order
  final CustomerModel customer;

  /// When the order was placed
  final DateTime date;

  /// Map of product IDs to quantities ordered
  /// Key: Product ID, Value: Quantity
  final Map<String, int> items;

  /// Human-readable order reference number
  final String orderNumber;

  /// Method used for payment (e.g., 'card')
  final String paymentMethod;

  /// Payment receipt details
  final Map<String, dynamic>? paymentReceipt;

  /// Shipping method (e.g., 'FREEDELIVERY')
  final String? shippingMethod;

  /// Shipping receipt details
  final Map<String, dynamic>? shippingReceipt;

  /// Total quoted price for the order
  final double totalQuote;

  const OrderModel({
    required this.id,
    required this.customer,
    required this.date,
    required this.items,
    required this.orderNumber,
    required this.paymentMethod,
    required this.totalQuote,
    this.paymentReceipt,
    this.shippingMethod,
    this.shippingReceipt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
