import 'package:json_annotation/json_annotation.dart';

part 'stripe_confirm_payment_intent_response.g.dart';

/// Represents a Stripe payment intent confirmation response.
///
/// This model contains the response from Stripe after confirming a payment intent.
/// It includes details about the payment status, amount, and various configuration options.
///
/// See Stripe API documentation:
/// https://stripe.com/docs/api/payment_intents/confirm
///
/// Example JSON:
/// ```json
/// {
///   "id": "pi_3MtweELkdIwHu7ix0Dt0gF2H",
///   "object": "payment_intent",
///   "amount": 2000,
///   "amount_capturable": 0,
///   "amount_details": {
///     "tip": {}
///   },
///   "amount_received": 2000,
///   "application": null,
///   "application_fee_amount": null,
///   "automatic_payment_methods": {
///     "enabled": true
///   },
///   "canceled_at": null,
///   "cancellation_reason": null,
///   "capture_method": "automatic",
///   "client_secret": "pi_3MtweELkdIwHu7ix0Dt0gF2H_secret_ALlpPMIZse0ac8YzPxkMkFgGC",
///   "confirmation_method": "automatic",
///   "created": 1680802258,
///   "currency": "usd",
///   "customer": null,
///   "description": null,
///   "last_payment_error": null,
///   "latest_charge": "ch_3MtweELkdIwHu7ix05lnLAFd",
///   "livemode": false,
///   "metadata": {},
///   "next_action": null,
///   "on_behalf_of": null,
///   "payment_method": "pm_1MtweELkdIwHu7ixxrsejPtG",
///   "payment_method_options": {
///     "card": {
///       "installments": null,
///       "mandate_options": null,
///       "network": null,
///       "request_three_d_secure": "automatic"
///     },
///     "link": {
///       "persistent_token": null
///     }
///   },
///   "payment_method_types": [
///     "card",
///     "link"
///   ],
///   "processing": null,
///   "receipt_email": null,
///   "review": null,
///   "setup_future_usage": null,
///   "shipping": null,
///   "source": null,
///   "statement_descriptor": null,
///   "statement_descriptor_suffix": null,
///   "status": "succeeded",
///   "transfer_data": null,
///   "transfer_group": null
/// }
/// ```
@JsonSerializable()
class StripeConfirmPaymentIntentResponse {
  /// The payment intent ID
  final String id;

  /// The type of object ('payment_intent')
  final String object;

  /// The amount in cents
  final int amount;

  /// Amount that can be captured
  @JsonKey(name: 'amount_capturable')
  final int? amountCapturable;

  /// Additional amount details
  @JsonKey(name: 'amount_details')
  final Map<String, dynamic>? amountDetails;

  /// Amount received in cents
  @JsonKey(name: 'amount_received')
  final int? amountReceived;

  /// Application ID if any
  final String? application;

  /// Application fee amount if any
  @JsonKey(name: 'application_fee_amount')
  final int? applicationFeeAmount;

  /// Automatic payment methods configuration
  @JsonKey(name: 'automatic_payment_methods')
  final Map<String, dynamic>? automaticPaymentMethods;

  /// When the payment intent was canceled, if applicable
  @JsonKey(name: 'canceled_at')
  final int? canceledAt;

  /// Reason for cancellation, if applicable
  @JsonKey(name: 'cancellation_reason')
  final String? cancellationReason;

  /// Capture method ('automatic' or 'manual')
  @JsonKey(name: 'capture_method')
  final String captureMethod;

  /// Client secret for the payment intent
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  /// Confirmation method ('automatic' or 'manual')
  @JsonKey(name: 'confirmation_method')
  final String confirmationMethod;

  /// When the payment intent was created (unix timestamp)
  final int created;

  /// Currency code (e.g., 'usd')
  final String currency;

  /// Customer ID if associated with a customer
  final String? customer;

  /// Description of the payment
  final String? description;

  /// Details of the last payment error if any
  @JsonKey(name: 'last_payment_error')
  final Map<String, dynamic>? lastPaymentError;

  /// ID of the latest charge
  @JsonKey(name: 'latest_charge')
  final String? latestCharge;

  /// Whether this is in live mode or test mode
  final bool livemode;

  /// Metadata associated with the payment intent
  final Map<String, dynamic>? metadata;

  /// Next actions required, if any
  @JsonKey(name: 'next_action')
  final Map<String, dynamic>? nextAction;

  /// On behalf of account, if any
  @JsonKey(name: 'on_behalf_of')
  final String? onBehalfOf;

  /// Payment method ID
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  /// Payment method options
  @JsonKey(name: 'payment_method_options')
  final Map<String, dynamic>? paymentMethodOptions;

  /// List of payment method types
  @JsonKey(name: 'payment_method_types')
  final List<String>? paymentMethodTypes;

  /// Processing details, if any
  final Map<String, dynamic>? processing;

  /// Email to send receipt to
  @JsonKey(name: 'receipt_email')
  final String? receiptEmail;

  /// ID of the review, if any
  final String? review;

  /// Setup future usage setting
  @JsonKey(name: 'setup_future_usage')
  final String? setupFutureUsage;

  /// Shipping details, if any
  final Map<String, dynamic>? shipping;

  /// Source used for the payment, if any
  final String? source;

  /// Statement descriptor
  @JsonKey(name: 'statement_descriptor')
  final String? statementDescriptor;

  /// Statement descriptor suffix
  @JsonKey(name: 'statement_descriptor_suffix')
  final String? statementDescriptorSuffix;

  /// Status of the payment intent
  final String status;

  /// Transfer data, if any
  @JsonKey(name: 'transfer_data')
  final Map<String, dynamic>? transferData;

  /// Transfer group, if any
  @JsonKey(name: 'transfer_group')
  final String? transferGroup;

  /// Creates a new [StripeConfirmPaymentIntentResponse].
  StripeConfirmPaymentIntentResponse({
    required this.id,
    required this.object,
    required this.amount,
    this.amountCapturable,
    this.amountDetails,
    this.amountReceived,
    this.application,
    this.applicationFeeAmount,
    this.automaticPaymentMethods,
    this.canceledAt,
    this.cancellationReason,
    required this.captureMethod,
    required this.clientSecret,
    required this.confirmationMethod,
    required this.created,
    required this.currency,
    this.customer,
    this.description,
    this.lastPaymentError,
    this.latestCharge,
    required this.livemode,
    this.metadata,
    this.nextAction,
    this.onBehalfOf,
    this.paymentMethod,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.processing,
    this.receiptEmail,
    this.review,
    this.setupFutureUsage,
    this.shipping,
    this.source,
    this.statementDescriptor,
    this.statementDescriptorSuffix,
    required this.status,
    this.transferData,
    this.transferGroup,
  });

  /// Creates a [StripeConfirmPaymentIntentResponse] from a JSON object.
  factory StripeConfirmPaymentIntentResponse.fromJson(
          Map<String, dynamic> json) =>
      _$StripeConfirmPaymentIntentResponseFromJson(json);

  /// Converts this [StripeConfirmPaymentIntentResponse] to a JSON object.
  Map<String, dynamic> toJson() =>
      _$StripeConfirmPaymentIntentResponseToJson(this);
}
