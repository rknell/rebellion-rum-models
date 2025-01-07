import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Represents a payment made against a sale.
///
/// Each payment records the payment method used, amount paid,
/// and an optional reference number for tracking purposes.
///
/// Example:
/// ```dart
/// final payment = Payment(
///   type: 'credit_card',
///   amount: 99.99,
///   reference: 'TXN-123456',
/// );
/// ```
@JsonSerializable()
class Payment {
  /// Payment method used (e.g., 'cash', 'credit_card', 'eftpos')
  final String type;

  /// Amount paid in this payment
  final double amount;

  /// Optional reference number (e.g., transaction ID, receipt number)
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
