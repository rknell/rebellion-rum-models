import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/shipping_quote_request_model.dart';
import 'startshipit_rate_destination_address_model.dart';

part 'payment_intent_request.g.dart';

/// Represents a request for creating a payment intent.
///
/// This model extends the ShippingQuoteRequestModel to include the shipping method
/// Given the shipping method, the items and the destination address, a quote
/// can be generated which will give the amount due - this is done server side
/// to avoid price manipulation.
///
/// Example:
/// ```dart
/// final request = PaymentIntentRequest(
///   address: destinationAddress,
///   items: {'product-123': 2, 'product-456': 1},
///   shippingMethod: 'express',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentIntentRequest extends ShippingQuoteRequestModel {
  final String shippingMethod;

  /// Creates a new payment intent request
  const PaymentIntentRequest({
    required super.address,
    required super.items,
    required this.shippingMethod,
  });

  /// Creates an instance from a JSON object
  factory PaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentRequestFromJson(json);

  /// Converts this instance to a JSON object
  @override
  Map<String, dynamic> toJson() => _$PaymentIntentRequestToJson(this);
}
