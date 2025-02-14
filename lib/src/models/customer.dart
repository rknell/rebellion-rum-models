import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'customer.g.dart';

/// Represents a customer in the system.
///
/// Customers can be either retail or wholesale, and may have various
/// preferences and contact information stored.
///
/// Example:
/// ```dart
/// final customer = CustomerModel(
///   firstName: 'John',
///   lastName: 'Doe',
///   email: 'john@example.com',
///   phone: '1234567890',
///   addressLine1: '123 Main St',
///   city: 'Melbourne',
///   state: 'VIC',
///   postcode: '3000',
/// );
/// ```
///
///

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
class CustomerModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

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

  /// First line of address
  String addressLine1;

  /// Second line of address (optional)
  String? addressLine2;

  /// City/suburb
  String city;

  /// State/province/region
  String state;

  /// Postal code
  String postcode;

  /// Country
  String country;

  bool isWholesale;

  Set<CustomerPreferences> preferences;

  CustomerModel(
      {ObjectId? id,
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
      this.isWholesale = false})
      : id = id ?? ObjectId(),
        preferences = preferences ?? <CustomerPreferences>{};

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
