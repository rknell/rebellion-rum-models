import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  final String type;
  final double amount;
  final String? reference;

  const Payment({
    required this.type,
    required this.amount,
    this.reference,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
