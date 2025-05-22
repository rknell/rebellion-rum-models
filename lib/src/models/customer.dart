import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

part 'customer.g.dart';

/// Represents a customer in the system, merging all fields from both
/// legacy CustomerModel and CustomerDetails (used in payment/order flows).
///
/// This is the canonical customer representation for all business logic.
///
/// Example:
/// ```dart
/// final customer = CustomerModel(
///   email: 'john@example.com',
///   firstName: 'John',
///   lastName: 'Doe',
///   companyName: 'Acme Pty Ltd',
///   addressLine1: '123 Main St',
///   addressLine2: 'Apt 4',
///   city: 'Melbourne',
///   state: 'VIC',
///   postcode: '3000',
///   country: 'AU',
///   phone: '1234567890',
///   isWholesale: false,
///   preferences: {CustomerPreferences.darkRum},
/// );
/// ```

enum CustomerPreferences {
  darkRum,
  spicedRum,
  whiteRum,
  coconutRum,
  rum,
  gin,
  blueGin,
  pinkGin,
  traditionalGin,
  citrusGin,
  vodka,
  beer,
  other,
}

@JsonSerializable()
class CustomerModel extends DatabaseSerializable {
  /// Company name (optional)
  String? companyName;

  /// Customer's first name
  String firstName;

  /// Customer's last name
  String lastName;

  /// Customer's email address
  String email;

  /// Contact phone number
  String phone;

  /// First line of address (street)
  String addressLine1;

  /// Second line of address (apartment, suite, etc.) (optional)
  String? addressLine2;

  /// City/suburb
  String city;

  /// State/province/region
  String state;

  /// Postal code
  String postcode;

  /// Country code (e.g., 'AU')
  String country;

  /// True if the customer is a wholesale customer
  bool isWholesale;

  /// Customer's product preferences (optional)
  Set<CustomerPreferences> preferences;

  /// Apartment, suite, etc. (alias for addressLine2, for compatibility)
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get apartment => addressLine2;

  /// Suburb (alias for city, for compatibility)
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get suburb => city;

  /// Address (alias for addressLine1, for compatibility)
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get address => addressLine1;

  CustomerModel({
    super.id,
    this.companyName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postcode,
    this.country = "Australia",
    Set<CustomerPreferences>? preferences,
    this.isWholesale = false,
  }) : preferences = preferences ?? <CustomerPreferences>{};

  /// Updates this customer with sanitized fields from another customer
  ///
  /// This method is used to safely update an existing customer with user-provided
  /// changes while ensuring that only allowed fields are modified.
  ///
  /// [source] - The source CustomerModel containing the changes to apply
  /// Returns this CustomerModel instance for method chaining
  CustomerModel mergeSanitized(CustomerModel source) {
    // Update personal information
    firstName = source.firstName;
    lastName = source.lastName;
    email = source.email;
    phone = source.phone;

    // Update address information
    companyName = source.companyName;
    addressLine1 = source.addressLine1;
    addressLine2 = source.addressLine2;
    city = source.city;
    state = source.state;
    postcode = source.postcode;
    country = source.country;

    // Update preferences
    preferences = source.preferences;

    // Note: isWholesale is not updated as it requires business approval

    return this;
  }

  StartShipItRateDestinationAddressModel
      toStartShipItRateDestinationAddressModel() {
    return StartShipItRateDestinationAddressModel(
      street:
          addressLine2 != null ? '$addressLine1, $addressLine2' : addressLine1,
      suburb: city,
      state: state,
      postCode: postcode,
      countryCode: country == 'Australia' ? 'AU' : country,
    );
  }

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
