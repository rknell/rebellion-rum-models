import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/stripe/stripe_shipping_details.dart';

part 'stripe_confirm_payment_intent_request.g.dart';

/// A request model for confirming a Stripe PaymentIntent.
///
/// Used to confirm that a customer intends to pay with current or provided payment method.
/// Upon confirmation, the PaymentIntent will attempt to initiate a payment.
///
/// If the selected payment method requires additional authentication steps, the PaymentIntent
/// will transition to the `requires_action` status and suggest additional actions.
/// If payment succeeds, the PaymentIntent will transition to the `succeeded` status.
///
/// See Stripe API documentation:
/// https://stripe.com/docs/api/payment_intents/confirm
///
/// Example usage:
/// ```dart
/// // Create a request to confirm a payment intent with a specific payment method
/// final request = StripeConfirmPaymentIntentRequest(
///   paymentMethod: 'pm_card_visa',
///   receiptEmail: 'customer@example.com',
///   returnUrl: 'https://example.com/payment/success',
/// );
///
/// // Convert to JSON for API request
/// final Map<String, dynamic> jsonData = request.toJson();
///
/// // Make API request to Stripe
/// final response = await stripeApiClient.confirmPaymentIntent(
///   'pi_3MtweELkdIwHu7ix0Dt0gF2H',
///   jsonData,
/// );
/// ```
@JsonSerializable()
class StripeConfirmPaymentIntentRequest {
  /// ID of the payment method (a PaymentMethod, Card, or compatible Source object)
  /// to attach to this PaymentIntent.
  @JsonKey(name: 'payment_method')
  final String? paymentMethod;

  /// Email address that the receipt for the resulting payment will be sent to.
  ///
  /// If specified for a payment in live mode, a receipt will be sent regardless
  /// of your Stripe email settings.
  @JsonKey(name: 'receipt_email')
  final String? receiptEmail;

  /// Indicates that you intend to make future payments with this PaymentIntent's payment method.
  ///
  /// If you provide a Customer with the PaymentIntent, you can use this parameter to
  /// attach the payment method to the Customer after the PaymentIntent is confirmed
  /// and the customer completes any required actions.
  ///
  /// When processing card payments, Stripe uses this field to help you comply with
  /// regional legislation and network rules, such as SCA.
  @JsonKey(
    name: 'setup_future_usage',
    defaultValue: StripeSetupFutureUsage.none,
    unknownEnumValue: StripeSetupFutureUsage.none,
  )
  final StripeSetupFutureUsage? setupFutureUsage;

  /// Shipping information for this PaymentIntent.
  final StripeShippingDetails? shipping;

  /// The URL to redirect your customer back to after they authenticate or cancel
  /// their payment on the payment method's app or site.
  @JsonKey(name: 'return_url')
  final String? returnUrl;

  /// Set to true to fail the payment attempt if the PaymentIntent transitions to `requires_action`.
  ///
  /// This parameter is only intended for direct integrations with the payment_intents API.
  @JsonKey(name: 'error_on_requires_action')
  final bool? errorOnRequiresAction;

  /// A string that identifies the resulting payment as part of a group.
  final String? mandate;

  /// If present, this property tells the SDK whether this payment requires
  /// 3D Secure authentication.
  ///
  /// If set to true, this payment will always undergo 3D Secure authentication.
  /// If set to false, this payment avoids 3D Secure when possible.
  /// If not provided, Stripe will determine the best value based on the
  /// card being used and the payment context.
  @JsonKey(name: 'use_stripe_sdk')
  final bool? useStripeSdk;

  /// Creates a new [StripeConfirmPaymentIntentRequest].
  StripeConfirmPaymentIntentRequest({
    this.paymentMethod,
    this.receiptEmail,
    this.setupFutureUsage,
    this.shipping,
    this.returnUrl,
    this.errorOnRequiresAction,
    this.mandate,
    this.useStripeSdk = false,
  });

  /// Creates a [StripeConfirmPaymentIntentRequest] from a JSON object.
  factory StripeConfirmPaymentIntentRequest.fromJson(
          Map<String, dynamic> json) =>
      _$StripeConfirmPaymentIntentRequestFromJson(json);

  /// Converts this [StripeConfirmPaymentIntentRequest] to a JSON object.
  Map<String, dynamic> toJson() =>
      _$StripeConfirmPaymentIntentRequestToJson(this);
}

/// Defines how the payment method attached to a successful PaymentIntent
/// can be used for future payments.
enum StripeSetupFutureUsage {
  /// Use 'off_session' if your customer may or may not be present in your checkout flow.
  ///
  /// This is appropriate for scenarios where you'll charge the customer later
  /// without their direct involvement (subscriptions, invoices, etc).
  @JsonValue('off_session')
  offSession,

  /// Use 'on_session' if you intend to only reuse the payment method
  /// when your customer is present in your checkout flow.
  ///
  /// This requires the customer's active participation in future transactions.
  @JsonValue('on_session')
  onSession,

  /// No future usage intended (default state).
  @JsonValue(null)
  none,
}
