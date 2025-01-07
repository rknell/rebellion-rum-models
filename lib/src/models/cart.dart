import 'package:json_annotation/json_annotation.dart';
import 'customer.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: '_id')
  final String id;
  final Customer customer;
  final Map<String, int> items;
  final List<String> appliedCoupons;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Cart({
    required this.id,
    required this.customer,
    required this.items,
    required this.appliedCoupons,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}
