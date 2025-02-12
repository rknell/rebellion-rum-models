import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Represents the type of payment used in a transaction
enum PaymentType { cash, eftpos, coupon, online, bank, unknown }

/// Represents a payment made against a sale.
///
/// Each payment records the payment method used, amount paid,
/// and an optional reference number for tracking purposes.
///
/// Example:
/// ```dart
/// final payment = PaymentModel(
///   type: PaymentType.bank,
///   amount: 99.99,
///   reference: 'TXN-123456',
/// );
/// ```
@JsonSerializable()
class PaymentModel {
  /// Payment method used
  @JsonKey(unknownEnumValue: PaymentType.unknown)
  PaymentType type;

  /// Amount paid in this payment
  double amount;

  /// Optional reference number (e.g., transaction ID, receipt number)
  String? reference;

  PaymentModel({
    required this.type,
    required this.amount,
    this.reference,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
