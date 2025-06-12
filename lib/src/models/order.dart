import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/customer.dart';

part 'order.g.dart';

/// Order status representing the current state of an order in the fulfillment process
enum OrderStatus {
  pending, // Initial state when order is created
  paid, // Payment confirmed, order being prepared
  shipped, // Order has been shipped
  delivered, // Order has been delivered
  cancelled // Order was cancelled
}

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
///   customerId: ObjectId(),
///   date: DateTime.now(),
///   items: {'PRODUCT-001': 2, 'PRODUCT-002': 1},
///   orderNumber: 'ORD-2024-001',
///   paymentMethod: 'credit_card',
///   totalQuote: 149.99,
///   status: OrderStatus.pending,
/// );
/// ```
@JsonSerializable()
class OrderModel extends DatabaseSerializable {
  /// Reference to the customer who placed the order
  @NullableObjectIdConverter()
  ObjectId? customerId;

  CustomerModel? customer;

  /// When the order was placed
  DateTime date;

  /// Map of product IDs to quantities ordered
  /// Key: Product ID, Value: Quantity
  Map<String, int> items;

  /// Human-readable order reference number, should be assigned on first save
  String? orderNumber;

  /// Method used for payment (e.g., 'card')
  String? paymentMethod;

  /// Current status of the order in the fulfillment process
  @JsonKey(
      defaultValue: OrderStatus.pending, unknownEnumValue: OrderStatus.pending)
  OrderStatus status;

  /// Metadata for the order
  Map<String, dynamic> metadata;

  /// Payment intent ID from Stripe
  String? paymentIntentClientSecret;

  /// Shipping method (e.g., 'FREEDELIVERY')
  String? shippingMethod;

  /// Shipping receipt details
  Map<String, dynamic>? shippingReceipt;

  /// Total quoted price for the order
  int? totalQuote;

  /// Additional notes for the order
  String? notes;

  OrderModel({
    super.id,
    required this.customerId,
    DateTime? date,
    required this.items,
    required this.orderNumber,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    this.totalQuote,
    Map<String, dynamic>? metadata,
    this.paymentIntentClientSecret,
    this.shippingMethod,
    this.shippingReceipt,
    this.notes,
  })  : date = date ?? DateTime.now(),
        metadata = metadata ?? {};

  /// Updates this order with sanitized fields from another order
  ///
  /// This method is used to safely update an existing order with user-provided
  /// changes while ensuring that only allowed fields are modified.
  /// Note: status is deliberately excluded to ensure it's managed by server-side logic.
  ///
  /// [source] - The source OrderModel containing the changes to apply
  /// Returns this OrderModel instance for method chaining
  OrderModel mergeSanitized(OrderModel source) {
    // Only specific fields can be edited
    items = source.items;
    shippingMethod = source.shippingMethod;
    notes = source.notes;
    // Status is deliberately not updated here as it should be managed by server-side logic
    // Reset totalQuote so it can be recalculated
    totalQuote = null;

    return this;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  /// Returns a sanitized JSON representation of the order
  ///
  /// This method returns a JSON map containing only fields that are safe
  /// to expose to clients. It excludes sensitive internal metadata fields
  /// while preserving all other order data.
  ///
  /// Returns a `Map<String, dynamic>` with the sanitized order data
  Map<String, dynamic> toJsonSanitized() {
    final json = toJson();
    json.remove('metadata');
    return json;
  }

  @override
  Set<String> get objectIdFields => {'_id', 'customerId'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {};

  @override
  Map<String, Function> get nestedTypes => {};
}
