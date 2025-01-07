import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Represents a payment made against a sale.
///
/// Each payment records the payment method used, amount paid,
/// and an optional reference number for tracking purposes.
///
/// Example:
/// ```dart
/// final payment = PaymentModel(
///   type: 'credit_card',
///   amount: 99.99,
///   reference: 'TXN-123456',
/// );
/// ```
@JsonSerializable()
class PaymentModel {
  /// Payment method used (e.g., 'cash', 'credit_card', 'eftpos')
  final String type;

  /// Amount paid in this payment
  final double amount;

  /// Optional reference number (e.g., transaction ID, receipt number)
  final String? reference;

  const PaymentModel({
    required this.type,
    required this.amount,
    this.reference,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
