import 'package:json_annotation/json_annotation.dart';

part 'confirm_payment_request.g.dart';

/// Represents a request to confirm a payment intent.
///
/// This model contains the necessary information to confirm a previously created
/// payment intent, including the payment intent ID and optional payment method ID.
///
/// Example:
/// ```dart
/// final request = ConfirmPaymentRequest(
///   paymentIntentId: 'pi_1234567890',
///   paymentMethodId: 'pm_1234567890',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class ConfirmPaymentRequest {
  /// The ID of the payment intent to confirm
  final String paymentIntentId;

  /// The optional ID of the payment method to use for confirmation
  final String? paymentMethodId;

  /// Creates a new payment confirmation request
  const ConfirmPaymentRequest({
    required this.paymentIntentId,
    this.paymentMethodId,
  });

  /// Creates an instance from a JSON object
  factory ConfirmPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentRequestFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ConfirmPaymentRequestToJson(this);
}
