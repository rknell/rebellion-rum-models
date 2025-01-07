import 'package:json_annotation/json_annotation.dart';

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
class CartModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Unique identifier for the cart session
  final String cartId;

  /// Selected delivery method and pricing
  final DeliveryMethodModel? deliveryMethod;

  /// List of products in the cart
  final List<CartProductModel> products;

  /// Customer information for delivery
  final UserInfoModel userInfo;

  /// Payment processing information
  final PaymentIntentModel? paymentIntent;

  const CartModel({
    required this.id,
    required this.cartId,
    this.deliveryMethod,
    required this.products,
    required this.userInfo,
    this.paymentIntent,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
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
@JsonSerializable()
class DeliveryMethodModel {
  /// Unique code identifying the delivery service
  final String service_code;

  /// Total delivery cost
  final double total_price;

  /// Display name of the delivery service
  final String service_name;

  const DeliveryMethodModel({
    required this.service_code,
    required this.total_price,
    required this.service_name,
  });

  factory DeliveryMethodModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryMethodModelToJson(this);
}

/// Represents a product in the shopping cart with quantity and display information.
///
/// This is a simplified version of the full Product model, containing only
/// the information needed for cart display and checkout.
///
/// Example:
/// ```dart
/// final cartProduct = CartProductModel(
///   id: '123',
///   name: 'Premium Rum',
///   href: '/products/premium-rum',
///   volume: 750,
///   price: 49.99,
///   quantity: 2,
///   imageSrc: 'https://...',
///   imageAlt: 'Premium Rum Bottle',
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

/// Represents a Stripe payment intent for processing payments.
///
/// Contains all necessary information for tracking and processing
/// a payment through the Stripe payment system.
///
/// Example:
/// ```dart
/// final intent = PaymentIntentModel(
///   object: 'payment_intent',
///   id: 'pi_123456',
///   amount: 4999,
///   amount_received: 4999,
///   automatic_payment_methods: {'enabled': true},
///   client_secret: 'pi_123456_secret_789',
///   currency: 'aud',
///   status: 'succeeded',
///   created: 1634567890,
///   metadata: {},
///   payment_method_types: ['card'],
/// );
/// ```
@JsonSerializable()
class PaymentIntentModel {
  /// Object type (always 'payment_intent')
  final String object;

  /// Stripe payment intent ID
  final String id;

  /// Payment amount in cents
  final int amount;

  /// Amount actually received in cents
  final int amount_received;

  /// Configuration for automatic payment methods
  final Map<String, dynamic> automatic_payment_methods;

  /// Secret used for client-side confirmation
  final String client_secret;

  /// Three-letter currency code (e.g., 'aud')
  final String currency;

  /// Current payment status
  final String status;

  /// Unix timestamp of creation
  final int created;

  /// Additional metadata attached to the payment
  final Map<String, dynamic> metadata;

  /// List of allowed payment method types
  final List<String> payment_method_types;

  const PaymentIntentModel({
    required this.object,
    required this.id,
    required this.amount,
    required this.amount_received,
    required this.automatic_payment_methods,
    required this.client_secret,
    required this.currency,
    required this.status,
    required this.created,
    required this.metadata,
    required this.payment_method_types,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentModelToJson(this);
}
