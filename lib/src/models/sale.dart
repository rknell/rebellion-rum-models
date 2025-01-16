import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'sale_item.dart';
import 'payment.dart';

part 'sale.g.dart';

/// Represents a completed sale transaction in the system.
///
/// A sale contains information about the items purchased, payments made,
/// any applied discounts, and customer information if available.
///
/// Example:
/// ```dart
/// final sale = SaleModel(
///   id: '123',
///   timestamp: DateTime.now(),
///   items: [SaleItemModel(...)],
///   total: 99.99,
///   payments: [PaymentModel(...)],
///   coupons: [],
/// );
/// ```
@JsonSerializable(explicitToJson: true)
class SaleModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;

  /// When the sale was completed
  final DateTime? timestamp;

  /// List of items included in the sale
  @JsonKey(defaultValue: <SaleItemModel>[])
  final List<SaleItemModel> items;

  /// Optional reference to the customer who made the purchase
  final String? customerId;

  /// Applied coupon codes or discount rules
  /// Can be either an empty object {} or an array []
  final dynamic coupons;

  /// Total sale amount before discounts
  final double? total;

  /// Total amount of discounts applied
  final double? discountTotal;

  /// Reference to EFTPOS payment session if applicable
  final String? eftposSessionId;

  /// List of payments made against this sale
  @JsonKey(defaultValue: <PaymentModel>[])
  final List<PaymentModel> payments;

  const SaleModel({
    required this.id,
    this.timestamp,
    required this.items,
    this.customerId,
    required this.coupons,
    this.total,
    this.discountTotal,
    this.eftposSessionId,
    required this.payments,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}
