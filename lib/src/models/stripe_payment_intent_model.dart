import 'package:json_annotation/json_annotation.dart';

part 'stripe_payment_intent_model.g.dart';

/// Represents a Stripe PaymentIntent response.
///
/// Contains all the information about a payment intent, including its status,
/// amount, currency, and associated payment method details.
///
/// Example:
/// ```dart
/// final paymentIntent = StripePaymentIntentModel(
///   id: 'pi_123',
///   amount: 1000,
///   currency: 'aud',
///   status: 'requires_payment_method',
///   clientSecret: 'pi_123_secret_xyz',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StripePaymentIntentModel {
  /// Unique identifier for the payment intent
  final String id;

  /// The amount in smallest currency unit (e.g., cents)
  final int amount;

  /// Three-letter ISO currency code
  final String currency;

  /// Current status of the payment intent
  final String status;

  /// Secret used on the client side to complete the payment
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  /// The payment method types that can be used with this payment intent
  @JsonKey(name: 'payment_method_types')
  final List<String> paymentMethodTypes;

  /// Optional description of the payment
  final String? description;

  /// Optional metadata associated with the payment intent
  final Map<String, String>? metadata;

  /// Whether this payment intent is in live mode
  final bool livemode;

  /// Unix timestamp of when the payment intent was created
  final int created;

  /// The capture method of the payment intent
  @JsonKey(name: 'capture_method')
  final String captureMethod;

  /// The confirmation method of the payment intent
  @JsonKey(name: 'confirmation_method')
  final String confirmationMethod;

  /// The amount that can be captured
  @JsonKey(name: 'amount_capturable')
  final int amountCapturable;

  /// The amount that has been received
  @JsonKey(name: 'amount_received')
  final int amountReceived;

  /// Payment method options for the payment intent
  @JsonKey(name: 'payment_method_options')
  final Map<String, dynamic>? paymentMethodOptions;

  const StripePaymentIntentModel({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.clientSecret,
    required this.paymentMethodTypes,
    required this.livemode,
    required this.created,
    required this.captureMethod,
    required this.confirmationMethod,
    required this.amountCapturable,
    required this.amountReceived,
    this.description,
    this.metadata,
    this.paymentMethodOptions,
  });

  /// Creates an instance from a JSON object
  factory StripePaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      _$StripePaymentIntentModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StripePaymentIntentModelToJson(this);
}
