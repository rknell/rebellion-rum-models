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
/// final customer = Customer(
///   id: '123',
///   email: 'john.doe@example.com',
///   firstName: 'John',
///   lastName: 'Doe',
///   phone: '0412345678',
///   isWholesale: false,
/// );
/// ```
@JsonSerializable()
class Customer {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Customer's email address (used as username)
  final String email;

  /// Customer's first name
  final String firstName;

  /// Customer's last name
  final String lastName;

  /// Contact phone number
  final String phone;

  /// Whether this is a wholesale customer
  final bool isWholesale;

  /// Optional company name for business customers
  final String? company;

  /// Customer's marketing preferences
  final Map<String, bool> preferences;

  const Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.isWholesale,
    this.company,
    this.preferences = const {},
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
