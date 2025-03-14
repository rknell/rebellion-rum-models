import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
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
class OrderModel extends DatabaseSerializable {
  /// Customer who placed the order
  CustomerModel customer;

  /// When the order was placed
  DateTime date;

  /// Map of product IDs to quantities ordered
  /// Key: Product ID, Value: Quantity
  Map<String, int> items;

  /// Human-readable order reference number
  String orderNumber;

  /// Method used for payment (e.g., 'card')
  String paymentMethod;

  /// Payment receipt details
  Map<String, dynamic>? paymentReceipt;

  /// Shipping method (e.g., 'FREEDELIVERY')
  String? shippingMethod;

  /// Shipping receipt details
  Map<String, dynamic>? shippingReceipt;

  /// Total quoted price for the order
  double totalQuote;

  OrderModel({
    super.id,
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
  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'customer': false,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'customer': CustomerModel.fromJson,
      };
}
