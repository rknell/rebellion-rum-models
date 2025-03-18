import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'cart.g.dart';

/// Represents a shopping cart in the e-commerce system.
///
/// A cart contains products selected by a user, delivery information,
/// user details, and optional payment intent for processing the transaction.
///
/// Example:
/// ```dart
/// final cart = CartModel(
///   id: '123',
///   cartId: 'cart_456',
///   products: [CartProductModel(...)],
///   userInfo: UserInfoModel(...),
/// );
/// ```
@JsonSerializable()
class CartModel extends DatabaseSerializable {
  /// Unique identifier for the cart session
  final String cartId;

  /// Selected delivery method and pricing
  DeliveryMethodModel? deliveryMethod;

  /// List of products in the cart
  List<CartProductModel> products;

  /// Customer information for delivery
  UserInfoModel userInfo;

  CartModel({
    super.id,
    required this.cartId,
    this.deliveryMethod,
    required this.products,
    required this.userInfo,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'deliveryMethod': false,
        'products': true,
        'userInfo': false,
        'paymentIntent': false,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'deliveryMethod': DeliveryMethodModel.fromJson,
        'products': CartProductModel.fromJson,
        'userInfo': UserInfoModel.fromJson,
      };
}

/// Represents a delivery method with associated service details and pricing.
///
/// Example:
/// ```dart
/// final delivery = DeliveryMethodModel(
///   service_code: 'express',
///   total_price: 15.99,
///   service_name: 'Express Delivery',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class DeliveryMethodModel {
  /// Service code identifier
  final String serviceCode;

  /// Total delivery cost
  final double totalPrice;

  /// Display name for the service
  final String serviceName;

  const DeliveryMethodModel({
    required this.serviceCode,
    required this.totalPrice,
    required this.serviceName,
  });

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryMethodModelToJson(this);
}

/// Represents a product in the shopping cart.
///
/// Example:
/// ```dart
/// final product = CartProductModel(
///   id: 'PROD-001',
///   name: 'Premium Dark Rum',
///   href: '/products/premium-dark-rum',
///   volume: 750,
///   price: 49.99,
///   quantity: 2,
///   imageSrc: '/images/rum.jpg',
///   imageAlt: 'Bottle of Premium Dark Rum',
///   barcode: '9876543210',
///   stock: 100,
/// );
/// ```
@JsonSerializable()
class CartProductModel {
  /// Product identifier
  final String id;

  /// Display name of the product
  final String name;

  /// URL path to product details
  final String href;

  /// Product volume in milliliters
  final int volume;

  /// Current unit price
  final double price;

  /// Quantity selected by customer
  final int quantity;

  /// Product image URL
  final String imageSrc;

  /// Alt text for product image
  final String imageAlt;

  /// Product barcode
  final String barcode;

  /// Current stock level
  final int stock;

  const CartProductModel({
    required this.id,
    required this.name,
    required this.href,
    required this.volume,
    required this.price,
    required this.quantity,
    required this.imageSrc,
    required this.imageAlt,
    required this.barcode,
    required this.stock,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      _$CartProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductModelToJson(this);
}

/// Contains customer information for delivery and contact purposes.
///
/// Example:
/// ```dart
/// final userInfo = UserInfoModel(
///   email: 'customer@example.com',
///   phone: '1234567890',
///   firstName: 'John',
///   lastName: 'Doe',
///   address: '123 Main St',
///   apartment: 'Apt 4B',
///   suburb: 'Downtown',
///   country: 'Australia',
///   state: 'VIC',
///   postcode: '3000',
/// );
/// ```
@JsonSerializable()
class UserInfoModel {
  /// Customer email address
  final String email;

  /// Contact phone number
  final String phone;

  /// Customer's first name
  final String firstName;

  /// Customer's last name
  final String lastName;

  /// Street address
  final String address;

  /// Apartment/unit number (optional)
  final String apartment;

  /// Suburb or city
  final String suburb;

  /// Country name
  final String country;

  /// State or territory
  final String state;

  /// Postal code
  final String postcode;

  const UserInfoModel({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.apartment,
    required this.suburb,
    required this.country,
    required this.state,
    required this.postcode,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
