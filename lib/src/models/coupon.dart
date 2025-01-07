import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  @JsonKey(name: '_id')
  final String id;
  final String code;
  final String description;
  final double amount;
  final String email;
  final String? phone;
  final bool? redeemed;
  final double? remainingValue;
  final double? originalAmount;

  const Coupon({
    required this.id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    this.remainingValue,
    this.originalAmount,
  });

  // coverage:ignore-line
  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
