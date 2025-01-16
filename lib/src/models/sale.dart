import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'sale_item.dart';
import 'payment.dart';
import 'coupon.dart';

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
  ObjectId id;

  /// When the sale was completed
  DateTime timestamp;

  /// List of items included in the sale
  @JsonKey(defaultValue: <SaleItemModel>[])
  List<SaleItemModel> items;

  /// Optional reference to the customer who made the purchase
  String? customerId;

  /// Applied coupon codes or discount rules
  /// Can be either an empty object {} or an array []
  @JsonKey(fromJson: _couponsFromJson)
  List<CouponModel> coupons;

  /// Total sale amount before discounts
  double? total;

  /// Total amount of discounts applied
  double? discountTotal;

  /// Reference to EFTPOS payment session if applicable
  String? eftposSessionId;

  /// List of payments made against this sale
  @JsonKey(defaultValue: <PaymentModel>[])
  List<PaymentModel> payments;

  /// Whether this sale was processed with mates rates pricing
  bool isMatesRates;

  static List<CouponModel> _couponsFromJson(dynamic json) {
    if (json == null) return <CouponModel>[];
    if (json is List) {
      return json
          .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map) {
      return json.values
          .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <CouponModel>[];
  }

  SaleModel({
    ObjectId? id,
    DateTime? timestamp,
    List<SaleItemModel>? items,
    this.customerId,
    dynamic coupons,
    this.total,
    this.discountTotal,
    this.eftposSessionId,
    List<PaymentModel>? payments,
    bool? isMatesRates,
  })  : id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now(),
        coupons = _couponsFromJson(coupons),
        items = items ?? [],
        payments = payments ?? [],
        isMatesRates = isMatesRates ?? false;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}
