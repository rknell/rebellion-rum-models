import 'package:json_annotation/json_annotation.dart';

part 'confirm_payment_response.g.dart';

/// Represents a response from confirming a payment intent.
///
/// This model contains information about the confirmed payment intent, including
/// the payment intent details and status.
///
/// Example:
/// ```dart
/// final response = ConfirmPaymentResponse(
///   success: true,
///   paymentIntent: {'id': 'pi_1234567890', 'status': 'succeeded'},
///   status: 'succeeded',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class ConfirmPaymentResponse {
  /// Whether the payment intent confirmation was successful
  final bool success;

  /// The status of the payment intent after confirmation
  final String? status;

  /// Optional server message for error or informational display to the customer
  final String? message;

  final String redirectUrl;

  /// Creates a new payment confirmation response
  const ConfirmPaymentResponse(
      {required this.success,
      this.status,
      this.message,
      required this.redirectUrl});

  /// Creates an instance from a JSON object
  factory ConfirmPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentResponseFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ConfirmPaymentResponseToJson(this);
}
