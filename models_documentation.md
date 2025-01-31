# Models Documentation

This documentation is automatically generated from the model files.

## bulk_storage_register_item

*File: lib/src/models/bulk_storage_register_item.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'bulk_storage_register_item.g.dart';

@JsonSerializable()
class BulkStorageRegisterItemModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  double lals;
  bool feintsDestroyed;
  bool wastage;
  String notes;
  String? fromChargeId;
  String? fromVesselId;
  String? toVesselId;
  String? toChargeId;
  String? toPackagingId;
  String? fromPackagingId;

  BulkStorageRegisterItemModel({
    ObjectId? id,
    required this.lals,
    required this.feintsDestroyed,
    required this.wastage,
    required this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
  }) : id = id ?? ObjectId();

  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);
}

```

## bulk_storage_vessel

*File: lib/src/models/bulk_storage_vessel.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
@JsonSerializable()
class BulkStorageVesselModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Unique identifier for the vessel
  String barcode;

  /// Name of the vessel
  String? name;

  /// Total capacity of the vessel in liters
  double capacity;

  /// Remaining LALs in the vessel
  double remainingLALs;

  BulkStorageVesselModel({
    ObjectId? id,
    required this.barcode,
    required this.name,
    required this.capacity,
    required this.remainingLALs,
  }) : id = id ?? ObjectId();

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);
}

```

## cart

*File: lib/src/models/cart.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
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
class CartModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Unique identifier for the cart session
  final String cartId;

  /// Selected delivery method and pricing
  DeliveryMethodModel? deliveryMethod;

  /// List of products in the cart
  List<CartProductModel> products;

  /// Customer information for delivery
  UserInfoModel userInfo;

  /// Payment processing information
  PaymentIntentModel? paymentIntent;

  CartModel({
    ObjectId? id,
    required this.cartId,
    this.deliveryMethod,
    required this.products,
    required this.userInfo,
    this.paymentIntent,
  }) : id = id ?? ObjectId();

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

```

## coupon

*File: lib/src/models/coupon.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'coupon.g.dart';

@JsonSerializable()
class CouponModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  ObjectId id;
  String code;
  String description;
  double amount;
  String? email;
  String? phone;
  bool? redeemed;
  double? remainingValue;
  double? originalAmount;

  CouponModel({
    ObjectId? id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    this.remainingValue,
    this.originalAmount,
  }) : id = id ?? ObjectId();

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);
}

```

## customer

*File: lib/src/models/customer.dart*

```dart
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

```

## delivery_authority

*File: lib/src/models/delivery_authority.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthorityModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  final String deliveryAuthorityNumber;
  final double lals;

  DeliveryAuthorityModel({
    ObjectId? id,
    required this.deliveryAuthorityNumber,
    required this.lals,
  }) : id = id ?? ObjectId();

  factory DeliveryAuthorityModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAuthorityModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryAuthorityModelToJson(this);
}

```

## distillation_record

*File: lib/src/models/distillation_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'distillation_record.g.dart';

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
@JsonSerializable()
class DistillationRecordModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// The still used for this distillation run
  String stillUsed;

  /// Amount of feints added during the run
  double feintsAdded;

  /// Amount of LALs charged during the run
  double lalsCharged;

  /// Total LALs charged for this run
  double totalLALsCharged;

  /// Total LALs yield from this run
  double totalLALsYield;

  /// Notes taken during the distillation process
  final List<NoteModel> notes;

  DistillationRecordModel({
    ObjectId? id,
    this.stillUsed = '',
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : id = id ?? ObjectId(),
        notes = notes ?? [];

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistillationRecordModelToJson(this);
}

@JsonSerializable()
class NoteModel {
  String content;
  final DateTime date;

  NoteModel({
    required this.content,
    required this.date,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

```

## eftpos_terminal

*File: lib/src/models/eftpos_terminal.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

part 'eftpos_terminal.g.dart';

class ObjectIdConverter implements JsonConverter<ObjectId, String> {
  const ObjectIdConverter();

  @override
  ObjectId fromJson(String json) => ObjectId.fromHexString(json);

  @override
  String toJson(ObjectId object) => object.toHexString();
}

@JsonSerializable(explicitToJson: true)
class EftposTerminalModel {
  @ObjectIdConverter()
  @JsonKey(name: '_id')
  final ObjectId id;
  final String name;
  final String secret;
  final DateTime createdAt;
  final DateTime lastUsed;

  EftposTerminalModel({
    ObjectId? id,
    required this.name,
    required this.secret,
    DateTime? createdAt,
    DateTime? lastUsed,
  })  : id = id ?? ObjectId(),
        createdAt = createdAt ?? DateTime.now(),
        lastUsed = lastUsed ?? DateTime.now();

  factory EftposTerminalModel.fromJson(Map<String, dynamic> json) =>
      _$EftposTerminalModelFromJson(json);

  Map<String, dynamic> toJson() => _$EftposTerminalModelToJson(this);
}

```

## excise_return

*File: lib/src/models/excise_return.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'excise_return.g.dart';

/// Represents an excise duty return for regulatory compliance.
@JsonSerializable()
class ExciseReturnModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Total volume of spirits in LALs (Liters of Absolute Alcohol)
  final double totalLals;

  /// Whether remission has been applied to this return
  final bool remissionApplied;

  ExciseReturnModel({
    ObjectId? id,
    required this.totalLals,
    required this.remissionApplied,
  }) : id = id ?? ObjectId();

  factory ExciseReturnModel.fromJson(Map<String, dynamic> json) =>
      _$ExciseReturnModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExciseReturnModelToJson(this);
}

```

## fermentation_record

*File: lib/src/models/fermentation_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'fermentation_record.g.dart';

enum FermentationType { molasses, caneSugar, grape, grain, mixed, other }

/// Represents a record of a fermentation batch in the production process.
///
/// Each fermentation record tracks the details of a single fermentation batch,
/// including ingredients, measurements, and timing information. This data is
/// crucial for quality control and regulatory compliance.
///
/// Example:
/// ```dart
/// final record = FermentationRecordModel(
///   id: '123',
///   batchNumber: 1,
///   type: FermentationType.molasses,
///   washVolume: 10.0,
///   vesselBarcode: 'FV-01',
///   sgStart: 1.080,
///   sgEnd: 1.010,
/// );
/// ```
@JsonSerializable()
class FermentationRecordModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Batch number for this fermentation
  int batchNumber;

  /// Type of fermentation (e.g., molasses, cane juice, mixed)
  @JsonKey(unknownEnumValue: FermentationType.other)
  FermentationType type;

  /// Volume of wash in liters
  double washVolume;

  /// Barcode identifier of the fermentation vessel
  String vesselBarcode;

  /// Starting specific gravity
  double sgStart;

  /// Final specific gravity
  double sgEnd;

  /// Progress measurements during fermentation
  List<FermentationProgressModel> fermentationProgress;

  /// Notes and observations
  String notes;

  FermentationRecordModel({
    ObjectId? id,
    required this.batchNumber,
    required this.type,
    required this.washVolume,
    required this.vesselBarcode,
    required this.sgStart,
    required this.sgEnd,
    List<FermentationProgressModel>? fermentationProgress,
    this.notes = '',
  })  : id = id ?? ObjectId(),
        fermentationProgress = fermentationProgress ?? [];

  factory FermentationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationRecordModelToJson(this);
}

@JsonSerializable()
class FermentationProgressModel {
  final double sg;
  final double? ph;
  final double? temp;
  final DateTime timestamp;
  final String notes;

  const FermentationProgressModel({
    required this.sg,
    this.ph,
    this.temp,
    required this.timestamp,
    required this.notes,
  });

  factory FermentationProgressModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationProgressModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationProgressModelToJson(this);
}

```

## order

*File: lib/src/models/order.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'customer.dart';

part 'order.g.dart';

/// Represents a customer order in the system.
///
/// An order contains customer information, ordered items, payment details,
/// and tracking information. Orders are used to track customer purchases
/// from placement through to fulfillment.
///
/// Example:
/// ```dart
/// final order = OrderModel(
///   id: '123',
///   customer: CustomerModel(...),
///   date: DateTime.now(),
///   items: {'PRODUCT-001': 2, 'PRODUCT-002': 1},
///   orderNumber: 'ORD-2024-001',
///   paymentMethod: 'credit_card',
///   totalQuote: 149.99,
/// );
/// ```
@JsonSerializable()
class OrderModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Customer who placed the order
  CustomerModel customer;

  /// When the order was placed
  DateTime date;

  /// Map of product IDs to quantities ordered
  /// Key: Product ID, Value: Quantity
  Map<String, int> items;

  /// Human-readable order reference number
  String orderNumber;

  /// Method used for payment (e.g., 'card')
  String paymentMethod;

  /// Payment receipt details
  Map<String, dynamic>? paymentReceipt;

  /// Shipping method (e.g., 'FREEDELIVERY')
  String? shippingMethod;

  /// Shipping receipt details
  Map<String, dynamic>? shippingReceipt;

  /// Total quoted price for the order
  double totalQuote;

  OrderModel({
    ObjectId? id,
    required this.customer,
    required this.date,
    required this.items,
    required this.orderNumber,
    required this.paymentMethod,
    required this.totalQuote,
    this.paymentReceipt,
    this.shippingMethod,
    this.shippingReceipt,
  }) : id = id ?? ObjectId();

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

```

## packaging_run_item

*File: lib/src/models/packaging_run_item.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'packaging_run_item.g.dart';

@JsonSerializable()
class PackagingRunItemModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String productBarcode;
  double unitSize;
  double strength;
  double unitsPackaged;
  double packagingLosses;
  double remaining;
  double volumeAvailable;
  double volumeRemaining;
  String exciseReturn;

  PackagingRunItemModel({
    ObjectId? id,
    required this.productBarcode,
    required this.unitSize,
    required this.strength,
    required this.unitsPackaged,
    required this.packagingLosses,
    required this.remaining,
    required this.volumeAvailable,
    required this.volumeRemaining,
    required this.exciseReturn,
  }) : id = id ?? ObjectId();

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);
}

```

## payment

*File: lib/src/models/payment.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

/// Represents the type of payment used in a transaction
enum PaymentType { cash, eftpos, coupon, online, unknown }

/// Represents a payment made against a sale.
///
/// Each payment records the payment method used, amount paid,
/// and an optional reference number for tracking purposes.
///
/// Example:
/// ```dart
/// final payment = PaymentModel(
///   type: PaymentType.creditCard,
///   amount: 99.99,
///   reference: 'TXN-123456',
/// );
/// ```
@JsonSerializable()
class PaymentModel {
  /// Payment method used
  @JsonKey(unknownEnumValue: PaymentType.unknown)
  PaymentType type;

  /// Amount paid in this payment
  double amount;

  /// Optional reference number (e.g., transaction ID, receipt number)
  String? reference;

  PaymentModel({
    required this.type,
    required this.amount,
    this.reference,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}

```

## postcode

*File: lib/src/models/postcode.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'postcode.g.dart';

/// Represents an Australian postcode and its associated location data.
///
/// This model stores information about Australian postcodes, including
/// the suburb, state, and delivery zone information. It's used for
/// shipping calculations and address validation.
///
/// Example:
/// ```dart
/// final postcode = PostcodeModel(
///   id: '123',
///   postcode: '3000',
///   suburb: 'Melbourne',
///   state: 'VIC',
///   deliveryZone: 'metro',
/// );
/// ```
@JsonSerializable()
class PostcodeModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Four-digit Australian postcode
  final String postcode;

  /// Suburb or locality name
  final String locality;

  /// State or territory code (e.g., 'VIC', 'NSW')
  final String state;

  /// Delivery zone classification for shipping
  final String combined;

  const PostcodeModel({
    required this.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.combined,
  });

  factory PostcodeModel.fromJson(Map<String, dynamic> json) =>
      _$PostcodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostcodeModelToJson(this);
}

```

## product

*File: lib/src/models/product.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'product.g.dart';

/// Represents a product in the Rebellion Rum inventory system.
///
/// Products can be either physical items (like bottles of rum) or digital items.
/// Each product has a unique identifier, barcode, and various attributes that
/// describe its characteristics and availability.
///
/// Example:
/// ```dart
/// final product = ProductModel(
///   id: '123',
///   barcode: '9876543210',
///   description: 'Premium Dark Rum',
///   price: 49.99,
///   stock: 100,
///   category: 'spirits',
///   isAvailableOnline: true,
/// );
/// ```

enum ProductCategory { vodka, gin, rum, softdrink, merch, other }

@JsonSerializable()
class ProductModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Unique barcode identifier for the product
  final String barcode;

  /// Product name/title

  String name;

  /// Current retail price in local currency
  double price;

  /// The discount we can give to friends of the distillery.
  double matesRatesPrice;

  /// Current stock level
  int stock;

  /// Product category
  @JsonKey(unknownEnumValue: ProductCategory.other)
  ProductCategory? category;

  /// Legacy product type string (for compatibility)
  String? productType;

  /// Whether the product can be purchased online
  bool isAvailableOnline;

  /// List of image URLs associated with the product
  List<String> images;

  /// Detailed product description for online store
  String? longDescription;

  /// Brief product description for listings
  String? shortDescription;

  /// Product volume in milliliters (ml)
  double volume;

  /// Product weight in kilograms (kg)
  double? weight;

  /// Alcohol by volume percentage
  double abv;

  /// Percentage of Australian content
  double percentAustralian;

  /// URL-friendly shortcut name
  String? shortcut;

  /// Whether the product is currently enabled for sale
  bool? enabled;

  ProductModel({
    ObjectId? id,
    required this.barcode,
    String? name,
    required this.price,
    int? stock = 0,
    ProductCategory? category,
    double? volume,
    double? abv,
    double? percentAustralian,
    this.productType,
    this.isAvailableOnline = false,
    this.images = const [],
    this.longDescription,
    this.shortDescription,
    this.weight,
    this.shortcut,
    this.enabled,
    double? matesRatesPrice,
  })  : id = id ?? ObjectId(),
        volume = volume ?? 700.0,
        abv = abv ?? 0.37,
        name = name ?? '',
        percentAustralian = percentAustralian ?? 1.0,
        matesRatesPrice = matesRatesPrice ?? price * .8,
        stock = stock ?? 0,
        category = category ?? ProductCategory.other;

  // coverage:ignore-line
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Handle the name/description merge during deserialization
    final name = json['name'] as String?;
    final description = json['description'] as String?;
    json = Map<String, dynamic>.from(json);
    json['name'] = name ?? description ?? '';

    return _$ProductModelFromJson(json);
  }
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

```

## raw_materials_register

*File: lib/src/models/raw_materials_register.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'raw_materials_register.g.dart';

@JsonSerializable()
class RawMaterialsRegisterModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String? invoiceNumber;
  String? fermentationRecordId;
  String materialType;
  int qtyIn;
  int qtyOut;

  RawMaterialsRegisterModel({
    ObjectId? id,
    this.invoiceNumber,
    this.fermentationRecordId,
    required this.materialType,
    required this.qtyIn,
    required this.qtyOut,
  }) : id = id ?? ObjectId();

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);
}

```

## sale

*File: lib/src/models/sale.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'sale_item.dart';
import 'payment.dart';
import 'coupon.dart';

part 'sale.g.dart';

/// Represents a completed sale transaction in the system.
///
/// A sale contains information about the items purchased, payments made,
/// any applied discounts, and customer information if available.
///
/// Example:
/// ```dart
/// final sale = SaleModel(
///   id: '123',
///   timestamp: DateTime.now(),
///   items: [SaleItemModel(...)],
///   total: 99.99,
///   payments: [PaymentModel(...)],
///   coupons: [],
/// );
/// ```
@JsonSerializable(explicitToJson: true)
class SaleModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  ObjectId id;

  /// When the sale was completed
  DateTime timestamp;

  /// List of items included in the sale
  @JsonKey(defaultValue: <SaleItemModel>[])
  List<SaleItemModel> items;

  /// Optional reference to the customer who made the purchase
  String? customerId;

  /// Applied coupon codes or discount rules
  /// Can be either an empty object {} or an array []
  @JsonKey(fromJson: _couponsFromJson)
  List<CouponModel> coupons;

  /// Total sale amount before discounts
  double? total;

  /// Total amount of discounts applied
  double? discountTotal;

  /// Reference to EFTPOS payment session if applicable
  String? eftposSessionId;

  /// List of payments made against this sale
  @JsonKey(defaultValue: <PaymentModel>[])
  List<PaymentModel> payments;

  /// Whether this sale was processed with mates rates pricing
  bool isMatesRates;

  static List<CouponModel> _couponsFromJson(dynamic json) {
    if (json == null) return <CouponModel>[];
    if (json is List) {
      return json
          .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map) {
      return json.values
          .map((e) => CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return <CouponModel>[];
  }

  SaleModel({
    ObjectId? id,
    DateTime? timestamp,
    List<SaleItemModel>? items,
    this.customerId,
    dynamic coupons,
    this.total,
    this.discountTotal,
    this.eftposSessionId,
    List<PaymentModel>? payments,
    bool? isMatesRates,
  })  : id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now(),
        coupons = _couponsFromJson(coupons),
        items = items ?? [],
        payments = payments ?? [],
        isMatesRates = isMatesRates ?? false;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);
}

```

## sale_item

*File: lib/src/models/sale_item.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'sale_item.g.dart';

/// Represents an individual item line in a sale.
///
/// Each SaleItemModel captures the essential information about a product
/// that was sold, including its description, price, and quantity.
///
/// Example:
/// ```dart
/// final item = SaleItemModel(
///   description: 'Premium Dark Rum 750ml',
///   price: 49.99,
///   itemId: 'PROD-001',
///   qty: 2,
/// );
/// ```
@JsonSerializable()
class SaleItemModel {
  /// Product description as shown on receipt
  String description;

  /// Unit price at time of sale
  double price;

  /// Reference to the product ID
  String itemId;

  /// Quantity sold
  int qty;

  SaleItemModel({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
  });

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);
}

```

## stock_journal

*File: lib/src/models/stock_journal.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations and packaging operations.
@JsonSerializable()
class StockJournalModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Barcode identifier for the product or vessel
  String barcode;

  /// Type of stock movement (e.g., 'packaging')
  String type;

  /// Source location or vessel ID
  String from;

  /// Destination location or vessel ID
  String to;

  /// Quantity moved
  double qty;

  StockJournalModel({
    ObjectId? id,
    required this.barcode,
    required this.type,
    required this.from,
    required this.to,
    required this.qty,
  }) : id = id ?? ObjectId();

  factory StockJournalModel.fromJson(Map<String, dynamic> json) =>
      _$StockJournalModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockJournalModelToJson(this);
}

```

## stock_location

*File: lib/src/models/stock_location.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_location.g.dart';

/// Represents a physical storage location for stock items.
///
/// Stock locations are used to track where products and materials are stored
/// within the facility. Each location has a unique identifier and specific flags
/// indicating its type and purpose.
@JsonSerializable()
class StockLocationModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Human-readable name for the location
  String name;

  /// Unique barcode identifier for the location
  String barcode;

  /// Indicates if this is a bond store location
  bool isBondStore;

  /// Indicates if this is a retail location
  bool isRetail;

  /// Indicates if stock in this location is available for online sales
  bool isAvailableOnline;

  /// Indicates if this is a warehouse location
  bool isWarehouse;

  /// Optional map of product barcodes to their stock levels
  Map<String, double>? stockLevels;

  StockLocationModel({
    ObjectId? id,
    required this.name,
    required this.barcode,
    required this.isBondStore,
    required this.isRetail,
    required this.isAvailableOnline,
    required this.isWarehouse,
    this.stockLevels,
  }) : id = id ?? ObjectId();

  factory StockLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StockLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockLocationModelToJson(this);
}

```

## volume_transferred_record

*File: lib/src/models/volume_transferred_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'volume_transferred_record.g.dart';

@JsonSerializable()
class VolumeTransferredRecordModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String chargeId;
  String washId;
  double volume;
  double lals;

  VolumeTransferredRecordModel({
    ObjectId? id,
    required this.chargeId,
    required this.washId,
    required this.volume,
    required this.lals,
  }) : id = id ?? ObjectId();

  factory VolumeTransferredRecordModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeTransferredRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$VolumeTransferredRecordModelToJson(this);
}

```

