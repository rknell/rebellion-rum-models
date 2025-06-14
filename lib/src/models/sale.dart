import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/sale_item.dart';
import 'package:rebellion_rum_models/src/models/payment.dart';
import 'package:rebellion_rum_models/src/models/coupon.dart';

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
class SaleModel extends DatabaseSerializable {
  /// When the sale was completed
  @JsonKey(name: 'timestamp')
  dynamic _timestamp;

  DateTime get timestamp {
    return _timestamp is String
        ? DateTime.tryParse(_timestamp)
        : _timestamp ?? id.dateTime;
  }

  set timestamp(DateTime time) {
    _timestamp = time;
  }

  /// Due date for credit sales
  DateTime? dueDate;

  /// Status of the sale (paid or unpaid)
  @JsonKey(defaultValue: SaleStatus.unpaid, unknownEnumValue: SaleStatus.unpaid)
  SaleStatus status;

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
          .map((e) => e is CouponModel
              ? e
              : CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map) {
      return json.values
          .map((e) => e is CouponModel
              ? e
              : CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <CouponModel>[];
  }

  SaleModel({
    super.id,
    DateTime? timestamp,
    List<SaleItemModel>? items,
    this.customerId,
    dynamic coupons,
    this.total,
    this.discountTotal,
    this.eftposSessionId,
    List<PaymentModel>? payments,
    bool? isMatesRates,
    this.dueDate,
    SaleStatus? status,
  })  : _timestamp = timestamp,
        coupons = _couponsFromJson(coupons),
        items = items ?? [],
        payments = payments ?? [],
        isMatesRates = isMatesRates ?? false,
        status = status ?? SaleStatus.unpaid;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

/// Status of a sale
enum SaleStatus {
  /// Sale is unpaid (has outstanding balance)
  unpaid,

  /// Sale is completed and fully paid
  paid
}
