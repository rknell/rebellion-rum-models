import 'package:json_annotation/json_annotation.dart';
import 'sale_item.dart';
import 'payment.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale {
  @JsonKey(name: '_id')
  final String id;
  final DateTime? timestamp;
  @JsonKey(defaultValue: <SaleItem>[])
  final List<SaleItem> items;
  final String? customerId;
  final dynamic coupons; // Can be {} or []
  final double? total;
  final double? discountTotal;
  final String? eftposSessionId;
  @JsonKey(defaultValue: <Payment>[])
  final List<Payment> payments;

  const Sale({
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

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
