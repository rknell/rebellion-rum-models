import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'customer.g.dart';

/// Represents a customer in the system.
///
/// Customers can be either retail or wholesale buyers. This model stores
/// their contact information and preferences. Note that sensitive information
/// like passwords are handled separately for security.
///
/// Example:
/// ```dart
/// final customer = CustomerModel(
///   id: '123',
///   email: 'john.doe@example.com',
///   firstName: 'John',
///   lastName: 'Doe',
///   phone: '0412345678',
///   isWholesale: false,
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
  other
}

@JsonSerializable()
class CustomerModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

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
  String addressLine2;

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
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.addressLine1,
      required this.addressLine2,
      required this.city,
      required this.state,
      required this.postcode,
      required this.country,
      Set<CustomerPreferences>? preferences,
      this.isWholesale = false})
      : id = id ?? ObjectId(),
        preferences = preferences ?? <CustomerPreferences>{};

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
