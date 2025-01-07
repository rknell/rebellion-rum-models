import 'package:json_annotation/json_annotation.dart';
import 'sale_item.dart';

part 'sale.g.dart';

@JsonSerializable()
class Sale {
  @JsonKey(name: '_id')
  final String id;
  final DateTime timestamp;
  final List<SaleItem> items;
  final String? customerId;
  final Map<String, dynamic> coupons;
  final double total;

  const Sale({
    required this.id,
    required this.timestamp,
    required this.items,
    this.customerId,
    required this.coupons,
    required this.total,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
