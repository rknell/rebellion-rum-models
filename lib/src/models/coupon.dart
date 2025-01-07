import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  @JsonKey(name: '_id')
  final String id;
  final String code;
  final String description;
  final double discount;
  final bool isPercentage;
  final bool isEnabled;
  final DateTime? expiryDate;
  final int? maxUses;
  final int usedCount;
  final List<String> applicableProducts;

  const Coupon({
    required this.id,
    required this.code,
    required this.description,
    required this.discount,
    required this.isPercentage,
    required this.isEnabled,
    this.expiryDate,
    this.maxUses,
    required this.usedCount,
    required this.applicableProducts,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
