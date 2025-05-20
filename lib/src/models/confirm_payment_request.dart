import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

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

  final PaymentIntentRequest order;

  final CustomerModel customer;

  final Map<String, double> items; //Barcode > Qty

  final String shippingMethod;

  /// Creates a new payment confirmation request
  /// Constructs a [ConfirmPaymentRequest] with all required fields.
  ///
  /// [paymentIntentId] - The Stripe payment intent ID to confirm.
  /// [paymentMethodId] - The Stripe payment method ID to use (nullable).
  /// [order] - The original payment intent request (contains address, items, shipping method).
  /// [customer] - The customer placing the order.
  /// [items] - Map of product barcodes to quantities.
  /// [shippingMethod] - The shipping method code.
  const ConfirmPaymentRequest({
    required this.paymentIntentId,
    required this.paymentMethodId,
    required this.order,
    required this.customer,
    required this.items,
    required this.shippingMethod,
  });

  /// Creates an instance from a JSON object
  factory ConfirmPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentRequestFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ConfirmPaymentRequestToJson(this);
}
