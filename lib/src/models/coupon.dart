import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'coupon.g.dart';

@JsonSerializable()
class CouponModel extends DatabaseSerializable {
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

  void redeem() {
    redeemed = true;
    remainingValue = 0;
  }

  CouponModel({
    super.id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    double? remainingValue,
  }) : _remainingValue = remainingValue;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
