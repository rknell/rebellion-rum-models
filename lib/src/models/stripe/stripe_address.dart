import 'package:json_annotation/json_annotation.dart';

part 'stripe_address.g.dart';

/// Postal address for shipping information in Stripe API requests.
///
/// This model represents a postal address as used in Stripe shipping
/// and customer information.
///
/// See Stripe API documentation:
/// https://stripe.com/docs/api/payment_intents/confirm#confirm_payment_intent-shipping
@JsonSerializable()
class StripeAddress {
  /// City, district, suburb, town, or village.
  final String? city;

  /// Two-letter country code (ISO 3166-1 alpha-2).
  final String? country;

  /// Address line 1 (e.g., street, PO Box, or company name).
  final String? line1;

  /// Address line 2 (e.g., apartment, suite, unit, or building).
  final String? line2;

  /// ZIP or postal code.
  @JsonKey(name: 'postal_code')
  final String? postalCode;

  /// State, county, province, or region.
  final String? state;

  /// Creates a new [StripeAddress].
  StripeAddress({
    this.city,
    this.country,
    this.line1,
    this.line2,
    this.postalCode,
    this.state,
  });

  /// Creates a [StripeAddress] from a JSON object.
  factory StripeAddress.fromJson(Map<String, dynamic> json) =>
      _$StripeAddressFromJson(json);

  /// Converts this [StripeAddress] to a JSON object.
  Map<String, dynamic> toJson() => _$StripeAddressToJson(this);
}
