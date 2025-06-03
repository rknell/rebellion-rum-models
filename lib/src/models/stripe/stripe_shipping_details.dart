import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/stripe/stripe_address.dart';

part 'stripe_shipping_details.g.dart';

/// Shipping information for a Stripe payment.
///
/// This model represents shipping details as used in Stripe payment intents
/// and other Stripe API objects.
///
/// See Stripe API documentation:
/// https://stripe.com/docs/api/payment_intents/confirm#confirm_payment_intent-shipping
@JsonSerializable()
class StripeShippingDetails {
  /// Shipping address.
  final StripeAddress? address;

  /// The delivery service that shipped a physical product,
  /// such as Fedex, UPS, USPS, etc.
  final String? carrier;

  /// Recipient name.
  final String? name;

  /// Recipient phone (including extension).
  final String? phone;

  /// The tracking number for a physical product,
  /// obtained from the delivery service.
  @JsonKey(name: 'tracking_number')
  final String? trackingNumber;

  /// Creates a new [StripeShippingDetails].
  StripeShippingDetails({
    this.address,
    this.carrier,
    this.name,
    this.phone,
    this.trackingNumber,
  });

  /// Creates a [StripeShippingDetails] from a JSON object.
  factory StripeShippingDetails.fromJson(Map<String, dynamic> json) =>
      _$StripeShippingDetailsFromJson(json);

  /// Converts this [StripeShippingDetails] to a JSON object.
  Map<String, dynamic> toJson() => _$StripeShippingDetailsToJson(this);
}
