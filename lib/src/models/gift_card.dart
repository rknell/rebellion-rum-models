import 'package:json_annotation/json_annotation.dart';
part 'gift_card.g.dart';

/// Face-value gift credit. Codes are assigned by the server after payment.
@JsonSerializable()
class GiftCardDetails {
  final int valueCents;
  final String? recipientName;
  final String? phone;
  final String? email;
  String? couponCode;

  GiftCardDetails(
      {required this.valueCents,
      this.recipientName,
      this.phone,
      this.email,
      this.couponCode});

  void validate() {
    if (valueCents <= 0 || valueCents > 1000000) {
      throw ArgumentError(
          'Gift card value must be between \$0.01 and \$10,000.');
    }
    for (final value in [recipientName, phone, email]) {
      if (value != null &&
          (value.length > 254 || value.contains(RegExp(r'[\r\n]')))) {
        throw ArgumentError(
            'Gift card contact details are too long or invalid.');
      }
    }
    if (email != null &&
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email!)) {
      throw ArgumentError('Enter a valid gift card email address.');
    }
  }

  factory GiftCardDetails.fromJson(Map<String, dynamic> json) =>
      _$GiftCardDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$GiftCardDetailsToJson(this);
}
