import 'package:json_annotation/json_annotation.dart';

part 'stripe_public_key_response.g.dart';

/// Represents a response from the Stripe Public Key API.
///
/// Contains the publishable key and success status.
///
/// Example:
/// ```dart
/// final response = StripePublicKeyResponse(
///   publishableKey: 'pk_test_example',
///   success: true,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StripePublicKeyResponse {
  /// The Stripe publishable key used for client-side initialization
  final String publishableKey;

  /// Whether the request was successful
  final bool success;

  const StripePublicKeyResponse({
    required this.publishableKey,
    required this.success,
  });

  /// Creates an instance from a JSON object
  factory StripePublicKeyResponse.fromJson(Map<String, dynamic> json) =>
      _$StripePublicKeyResponseFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StripePublicKeyResponseToJson(this);
}
