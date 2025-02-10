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
  String? email;
  String? phone;
  bool? redeemed;

  @JsonKey(name: 'remainingValue')
  double? _remainingValue;

  double get remainingValue {
    if (redeemed == true) {
      return 0;
    } else {
      return _remainingValue ?? amount;
    }
  }

  set remainingValue(double value) => _remainingValue = value;

  double get currentValue => remainingValue;

  redeem() {
    redeemed = true;
    remainingValue = 0;
  }

  CouponModel({
    ObjectId? id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    double? remainingValue,
  })  : id = id ?? ObjectId(),
        _remainingValue = remainingValue;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}
