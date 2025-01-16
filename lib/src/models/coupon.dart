import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'coupon.g.dart';

@JsonSerializable()
class CouponModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;
  final String code;
  final String description;
  final double amount;
  final String email;
  final String? phone;
  final bool? redeemed;
  final double? remainingValue;
  final double? originalAmount;

  const CouponModel({
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
  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
