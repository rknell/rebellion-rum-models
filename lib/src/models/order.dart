import 'package:json_annotation/json_annotation.dart';
import 'customer.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String id;
  final Customer customer;
  final DateTime date;
  final Map<String, int> items;
  final String orderNumber;
  final String paymentMethod;
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
