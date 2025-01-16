import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'coupon.g.dart';

@JsonSerializable()
class CouponModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  ObjectId id;
  String code;
  String description;
  double amount;
  String email;
  String? phone;
  bool? redeemed;
  double? remainingValue;
  double? originalAmount;

  CouponModel({
    ObjectId? id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    this.remainingValue,
    this.originalAmount,
  }) : id = id ?? ObjectId();

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
