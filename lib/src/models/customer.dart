import 'package:json_annotation/json_annotation.dart';

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
@JsonSerializable()
class CustomerModel {
  /// Customer's first name
  final String firstName;

  /// Customer's last name
  final String lastName;

  /// Customer's email address
  final String email;

  /// Contact phone number
  final String phone;

  /// First line of address
  final String addressLine1;

  /// Second line of address (optional)
  final String addressLine2;

  /// City/suburb
  final String city;

  /// State/province/region
  final String state;

  /// Postal code
  final String postcode;

  /// Country
  final String country;

  const CustomerModel({
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
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}
