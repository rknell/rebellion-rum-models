# Models Documentation

This documentation is automatically generated from the model files.

## alcocalc_dilution_calculation

*File: lib/src/models/alcocalc_dilution_calculation.dart*

```dart
import 'package:alcocalc/alcocalc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alcocalc_dilution_calculation.g.dart';

/// A model for recording dilution calculations using the alcocalc package.
/// This model stores the input parameters and calculated results for audit purposes.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionCalculation {
  /// Creates a new instance of [AlcocalcDilutionCalculation].
  factory AlcocalcDilutionCalculation({
    required double startingWeight,
    required double startingAbv,
    required double targetAbv,
    List<SugarAddition> sugars = const [],
    double temperature = 20.0,
  }) {
    // Validate inputs
    if (startingAbv <= targetAbv) {
      throw ArgumentError('Starting ABV must be greater than target ABV');
    }
    if (startingAbv <= 0 || startingAbv > 100) {
      throw ArgumentError('Starting ABV must be between 0 and 100');
    }
    if (targetAbv <= 0 || targetAbv > 100) {
      throw ArgumentError('Target ABV must be between 0 and 100');
    }
    if (temperature < -20 || temperature > 40) {
      throw ArgumentError('Temperature must be between -20°C and 40°C');
    }

    // Calculate dilution once
    final result = dilution(
      startingWeight: startingWeight,
      startingABV: startingAbv,
      startingTemperature: temperature,
      sugars: sugars.map((s) => s.toSugars()).toList(),
      targetABV: targetAbv,
    );

    // Create instance with all values
    return AlcocalcDilutionCalculation._(
      startingWeight: startingWeight,
      startingAbv: startingAbv,
      targetAbv: targetAbv,
      temperature: temperature,
      sugars: sugars,
      date: DateTime.now(),
      waterToAdd: result.additionalWaterLitres,
      weightAfterWater: result.targetWeightAfterWater,
      finalVolume: result.targetVolume,
      lals: result.lals,
      expectedBottles: result.expectedBottles,
      calculatedAbv: result.calculatedABV,
      acceptableAbvLow: result.acceptableABVLow,
      acceptableAbvHigh: result.acceptableABVHigh,
      sugarResults: result.sugarResults
          .map((sugar) => SugarResult(
                name: sugar.name,
                weight: sugar.weight,
              ))
          .toList(),
    );
  }

  /// Private constructor for creating an instance with pre-calculated values
  const AlcocalcDilutionCalculation._({
    required this.startingWeight,
    required this.startingAbv,
    required this.targetAbv,
    required this.temperature,
    required this.sugars,
    required this.date,
    required this.waterToAdd,
    required this.weightAfterWater,
    required this.finalVolume,
    required this.lals,
    required this.expectedBottles,
    required this.calculatedAbv,
    required this.acceptableAbvLow,
    required this.acceptableAbvHigh,
    required this.sugarResults,
  });

  /// Starting weight in kilograms
  final double startingWeight;

  /// Starting alcohol by volume percentage
  final double startingAbv;

  /// Target alcohol by volume percentage
  final double targetAbv;

  /// Temperature in celsius
  final double temperature;

  /// Optional list of sugars to add (for liqueurs)
  final List<SugarAddition> sugars;

  /// Date and time of calculation
  final DateTime date;

  /// Amount of water to add in litres to reach target ABV
  final double waterToAdd;

  /// Target weight after adding water (before sugar additions)
  final double weightAfterWater;

  /// Final volume after dilution in litres
  final double finalVolume;

  /// Total litres of absolute alcohol (LALs)
  final double lals;

  /// Expected number of 700ml bottles
  final double expectedBottles;

  /// Calculated ABV after all additions
  final double calculatedAbv;

  /// Minimum acceptable ABV for quality control
  final double acceptableAbvLow;

  /// Maximum acceptable ABV for quality control
  final double acceptableAbvHigh;

  /// List of sugar additions with calculated weights
  final List<SugarResult> sugarResults;

  /// Creates an instance from a JSON object
  factory AlcocalcDilutionCalculation.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionCalculationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$AlcocalcDilutionCalculationToJson(this);
}

/// Represents a sugar addition in the dilution calculation
@JsonSerializable(explicitToJson: true)
class SugarAddition {
  /// Name of the sugar (e.g., "White Sugar", "Honey", etc.)
  final String name;

  /// Specific gravity of the sugar
  final double specificGravity;

  /// Percentage of sugar to add (as a decimal, e.g., 0.1 for 10%)
  final double percentage;

  /// Creates a new instance of [SugarAddition]
  SugarAddition({
    required this.name,
    required this.specificGravity,
    required this.percentage,
  }) : assert(percentage < 1, "Percentage must be a decimal");

  /// Converts this instance to a Sugars object for calculation
  Sugars toSugars() => Sugars(
        name: name,
        specificGravity: specificGravity,
        percentage: percentage,
      );

  /// Creates an instance from a JSON object
  factory SugarAddition.fromJson(Map<String, dynamic> json) =>
      _$SugarAdditionFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$SugarAdditionToJson(this);
}

/// Represents the result of a sugar addition calculation
@JsonSerializable(explicitToJson: true)
class SugarResult {
  /// Name of the sugar
  final String name;

  /// Weight of sugar to add in kilograms
  final double weight;

  /// Creates a new instance of [SugarResult]
  SugarResult({
    required this.name,
    required this.weight,
  });

  /// Creates an instance from a JSON object
  factory SugarResult.fromJson(Map<String, dynamic> json) =>
      _$SugarResultFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$SugarResultToJson(this);
}

```

## alcocalc_lals_calculation

*File: lib/src/models/alcocalc_lals_calculation.dart*

```dart
import "package:alcocalc/alcocalc.dart";
import 'package:json_annotation/json_annotation.dart';

part 'alcocalc_lals_calculation.g.dart';

/// A model for calculating litres of alcohol (LALs) using the alcocalc package.
@JsonSerializable(explicitToJson: true)
class AlcocalcLalsCalculation {
  /// Creates a new instance of [AlcocalcLalsCalculation].
  AlcocalcLalsCalculation({
    required this.weight,
    required this.abv,
    required this.temperature,
  }) : lals = Alcocalc.litresOfAlcoholCalculation(
          weight: weight,
          abv: abv,
          temperature: temperature,
        );

  /// Weight in kilograms
  final double weight;

  /// Alcohol by volume percentage
  final double abv;

  /// Temperature in celsius
  final double temperature;

  /// Litres of alcohol calculated from the given parameters
  final double lals;

  /// Creates an instance from a JSON object
  factory AlcocalcLalsCalculation.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcLalsCalculationFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$AlcocalcLalsCalculationToJson(this);
}

```

## bulk_storage_movement_type

*File: lib/src/models/bulk_storage_movement_type.dart*

```dart
/// Represents different types of movements in the bulk storage system.
enum BulkStorageMovementType {
  /// Movement from still to vessel
  fromStill,

  /// Movement between vessels
  vesselTransfer,

  /// Movement to still for re-distillation
  toStill,

  /// Movement to packaging
  toPackaging,

  /// Underbond movement
  underbond,

  /// Feints destroyed
  feintsDestroyed,

  /// Manufacture operations (mixing, dilution)
  manufacture,

  /// Stocktake adjustment
  stocktake,

  /// Wastage
  wastage,

  /// The default return type if the others ca
  unknown,
}

```

## bulk_storage_register_item

*File: lib/src/models/bulk_storage_register_item.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';
import 'package:rebellion_rum_models/src/models/bulk_storage_movement_type.dart';

part 'bulk_storage_register_item.g.dart';

/// Represents an entry in the bulk storage register.
/// Each entry tracks a movement or adjustment of spirits between vessels,
/// to/from packaging, or other operations like stocktake adjustments.
@JsonSerializable(explicitToJson: true)
class BulkStorageRegisterItemModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// LALs calculation for this movement
  @JsonKey(includeIfNull: false)
  final AlcocalcLalsCalculation? lalsCalculation;

  /// Legacy LALs value (used for backward compatibility)
  @JsonKey(name: 'lals')
  final double? legacyLals;

  /// Whether this movement represents a stocktake adjustment
  bool isStocktake;

  /// Type of movement

  /// Calculates the movement type based on the source and destination fields
  BulkStorageMovementType get movementType {
    // Handle explicit cases first
    if (isStocktake) return BulkStorageMovementType.stocktake;
    if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    if (wastage) return BulkStorageMovementType.wastage;

    // Handle vessel/charge/packaging transfers
    if (fromChargeId != null) {
      if (toVesselId != null) return BulkStorageMovementType.fromStill;
      // If no destination and feints destroyed, it's still feints destroyed
      if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    }

    if (fromVesselId != null) {
      if (toChargeId != null) return BulkStorageMovementType.toStill;
      if (toPackagingId != null) return BulkStorageMovementType.toPackaging;
      if (toVesselId != null) return BulkStorageMovementType.vesselTransfer;
    }

    return BulkStorageMovementType.unknown;
  }

  /// Whether this movement represents destroyed feints
  bool feintsDestroyed;

  /// Whether this movement represents wastage
  bool wastage;

  /// Optional notes about the movement
  String? notes;

  /// Reference to the source charge (if applicable)
  @JsonKey(name: 'fromChargeId')
  @NullableObjectIdConverter()
  ObjectId? fromChargeId;

  /// Reference to the source vessel (if applicable)
  @JsonKey(name: 'fromVesselId')
  @NullableObjectIdConverter()
  ObjectId? fromVesselId;

  /// Reference to the destination vessel (if applicable)
  @JsonKey(name: 'toVesselId')
  @NullableObjectIdConverter()
  ObjectId? toVesselId;

  /// Reference to the destination charge (if applicable)
  @JsonKey(name: 'toChargeId')
  @NullableObjectIdConverter()
  ObjectId? toChargeId;

  /// Reference to the destination packaging (if applicable)
  @JsonKey(name: 'toPackagingId')
  @NullableObjectIdConverter()
  ObjectId? toPackagingId;

  /// Reference to the source packaging (if applicable)
  @JsonKey(name: 'fromPackagingId')
  @NullableObjectIdConverter()
  ObjectId? fromPackagingId;

  /// Reference to the product being moved
  @JsonKey(name: 'productId')
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Timestamp extracted from the document's ObjectId
  DateTime get timestamp => id.dateTime;

  BulkStorageRegisterItemModel({
    ObjectId? id,
    this.lalsCalculation,
    this.legacyLals,
    this.feintsDestroyed = false,
    this.wastage = false,
    this.isStocktake = false,
    this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
    this.productId,
  })  : assert(lalsCalculation != null || legacyLals != null,
            'Either lalsCalculation or legacyLals must be provided'),
        id = id ?? ObjectId();

  /// Get the LALs value from either the calculation or legacy field
  /// If lalsCalculation exists, use its value
  /// Otherwise fall back to legacyLals if it exists and is greater than 0
  /// If neither exists, return 0
  double get lals {
    if (lalsCalculation != null) {
      return lalsCalculation!.lals;
    }
    if (legacyLals != null && legacyLals! > 0) {
      return legacyLals!;
    }
    return 0;
  }

  factory BulkStorageRegisterItemModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);

  @override
  Map<String, dynamic> toDatabase() {
    final json = toJson();
    // Convert all ObjectId fields to BSON ObjectIds
    if (fromChargeId != null) json['fromChargeId'] = fromChargeId;
    if (fromVesselId != null) json['fromVesselId'] = fromVesselId;
    if (toVesselId != null) json['toVesselId'] = toVesselId;
    if (toChargeId != null) json['toChargeId'] = toChargeId;
    if (toPackagingId != null) json['toPackagingId'] = toPackagingId;
    if (fromPackagingId != null) json['fromPackagingId'] = fromPackagingId;
    if (productId != null) json['productId'] = productId;
    json['_id'] = id;
    return json;
  }

  @override
  Set<String> get objectIdFields => {
        '_id',
        'fromChargeId',
        'fromVesselId',
        'toVesselId',
        'toChargeId',
        'toPackagingId',
        'fromPackagingId',
        'productId',
      };
}

```

## bulk_storage_vessel

*File: lib/src/models/bulk_storage_vessel.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/bulk_storage_vessel_status.dart';

part 'bulk_storage_vessel.g.dart';

/// Represents a bulk storage vessel used for storing spirits.
@JsonSerializable()
class BulkStorageVesselModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Unique identifier for the vessel
  String barcode;

  /// Name of the vessel
  @JsonKey(name: 'name')
  String? _name;

  /// Gets the name of the vessel, falling back to barcode if no name is set
  String get name {
    var setName = _name;
    if (setName != null && setName.isNotEmpty) {
      return setName;
    } else {
      return barcode;
    }
  }

  /// Sets the name of the vessel
  set name(String? value) => _name = value;

  /// Total capacity of the vessel in liters
  double capacity;

  /// Current LALs in the vessel, this is a cached calculation based on adding
  /// up the records in BulkStorageRegisterItem
  double currentLals;

  /// Status of the vessel
  BulkStorageVesselStatus status;

  /// Reference to the product currently in the vessel
  @JsonKey(name: 'productId')
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Whether the vessel needs a stocktake before operations
  bool needsStocktake;

  BulkStorageVesselModel({
    ObjectId? id,
    required this.barcode,
    String? name,
    required this.capacity,
    this.currentLals = 0,
    this.status = BulkStorageVesselStatus.active,
    this.productId,
    this.needsStocktake = false,
  })  : id = id ?? ObjectId(),
        _name = name;

  /// Get the remaining LALs in the vessel
  double get remainingLALs => currentLals;

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageVesselModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'productId'};
}

```

## bulk_storage_vessel_status

*File: lib/src/models/bulk_storage_vessel_status.dart*

```dart
/// Represents the status of a bulk storage vessel.
enum BulkStorageVesselStatus {
  /// Vessel is active and can be used
  active,

  /// Vessel has been decommissioned and cannot be used
  decommissioned,

  /// Vessel is temporarily out of service
  maintenance,
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
class CartModel with DatabaseSerializable {
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
        'paymentIntent': PaymentIntentModel.fromJson,
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
class DeliveryMethodModel with DatabaseSerializable {
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
class CartProductModel with DatabaseSerializable {
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
class UserInfoModel with DatabaseSerializable {
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
@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentIntentModel with DatabaseSerializable {
  final String object;
  final String id;
  final int amount;
  final int amountReceived;
  final Map<String, dynamic> automaticPaymentMethods;
  final String clientSecret;
  final String currency;
  final String status;
  final int created;
  final Map<String, dynamic> metadata;
  final List<String> paymentMethodTypes;

  const PaymentIntentModel({
    required this.object,
    required this.id,
    required this.amount,
    required this.amountReceived,
    required this.automaticPaymentMethods,
    required this.clientSecret,
    required this.currency,
    required this.status,
    required this.created,
    required this.metadata,
    required this.paymentMethodTypes,
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
class CouponModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  ObjectId id;
  String code;
  String description;
  double amount;
  String? email;
  String? phone;
  bool? redeemed;

  @JsonKey(name: 'remainingValue')
  double? _remainingValue;

  double get remainingValue {
    if (redeemed == true) {
      return 0;
    } else {
      return _remainingValue ?? amount;
    }
  }

  set remainingValue(double value) => _remainingValue = value;

  double get currentValue => remainingValue;

  void redeem() {
    redeemed = true;
    remainingValue = 0;
  }

  CouponModel({
    ObjectId? id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    double? remainingValue,
  })  : id = id ?? ObjectId(),
        _remainingValue = remainingValue;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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

```

## delivery_authority

*File: lib/src/models/delivery_authority.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthorityModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## distillation_record

*File: lib/src/models/distillation_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../json_helpers.dart';

part 'distillation_record.g.dart';

/// Status of a distillation record
enum DistillationStatus {
  /// Record is being created/edited
  inProgress,

  /// Distillation is complete
  completed,

  /// Record has been archived
  archived
}

/// Represents a record of a distillation run in the production process.
///
/// Each distillation record tracks the details of a single distillation run,
/// including the still used, LALs measurements, and any notes taken during the process.
/// The record's ObjectId serves as the charge number, using its timestamp for sequential tracking.
@JsonSerializable()
class DistillationRecordModel with DatabaseSerializable {
  /// MongoDB document ID (also serves as charge number via timestamp)
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// The still used for this distillation run
  String stillUsed;

  /// Start time of the distillation
  final DateTime startTime;

  /// Current status of the distillation record
  @JsonKey(defaultValue: DistillationStatus.inProgress)
  final DistillationStatus status;

  /// Amount of feints added during the run
  double feintsAdded;

  /// Amount of LALs charged during the run
  double lalsCharged;

  /// Total LALs charged for this run (including all inputs)
  double totalLALsCharged;

  /// Total LALs yield from this run (sum of all outputs)
  double totalLALsYield;

  /// Notes taken during the distillation process
  final List<NoteModel> notes;

  DistillationRecordModel({
    ObjectId? id,
    this.stillUsed = '',
    DateTime? startTime,
    this.status = DistillationStatus.inProgress,
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : id = id ?? ObjectId(),
        startTime = startTime ?? DateTime.now(),
        notes = notes ?? [];

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$DistillationRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'notes': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'notes': NoteModel.fromJson,
      };
}

/// Represents a note in the distillation process
@JsonSerializable()
class NoteModel with DatabaseSerializable {
  String content;
  final DateTime date;
  final bool isSystem;

  NoteModel({
    required this.content,
    required this.date,
    this.isSystem = false,
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
import '../json_helpers.dart';

part 'eftpos_terminal.g.dart';

@JsonSerializable()
class EftposTerminalModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
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
class ExciseReturnModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## fermentation_record

*File: lib/src/models/fermentation_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'fermentation_record.g.dart';

/// Represents a fermentation batch record in the production process.
///
/// Each fermentation record tracks the details of a single fermentation batch,
/// including measurements, vessel information, and progress readings.
///
/// Example:
/// ```dart
/// final record = FermentationRecordModel(
///   batchNumber: 123,
///   type: FermentationType.molasses,
///   washVolume: 1000,
///   vesselBarcode: 'FV001',
///   sgStart: 1.080,
///   sgEnd: 1.010,
/// );
/// ```
enum FermentationType {
  /// Fermentation using molasses as primary fermentable
  molasses,

  /// Fermentation using cane sugar as primary fermentable
  caneSugar,

  /// Fermentation using grape as primary fermentable
  grape,

  /// Fermentation using grain as primary fermentable
  grain,

  /// Mixed fermentation using multiple fermentable sources
  mixed,

  /// Other fermentation types
  other
}

@JsonSerializable()
class FermentationRecordModel with DatabaseSerializable {
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

  /// Recipe details and instructions
  String recipe;

  /// Whether the fermentation is complete (all wash transferred)
  bool completed;

  /// Date when the fermentation was marked as complete
  DateTime? completionDate;

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
    this.recipe = '',
    this.completed = false,
    this.completionDate,
  })  : id = id ?? ObjectId(),
        fermentationProgress = fermentationProgress ?? [];

  factory FermentationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$FermentationRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'fermentationProgress': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'fermentationProgress': FermentationProgressModel.fromJson,
      };
}

@JsonSerializable()
class FermentationProgressModel with DatabaseSerializable {
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
class OrderModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'customer': false,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'customer': CustomerModel.fromJson,
      };
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
class PackagingRunItemModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## payment

*File: lib/src/models/payment.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'payment.g.dart';

/// Represents the type of payment used in a transaction
enum PaymentType { cash, eftpos, coupon, online, bank, unknown }

/// Represents a payment made against a sale.
///
/// Each payment record tracks the amount, method, and any associated
/// transaction details or receipts.
///
/// Example:
/// ```dart
/// final payment = PaymentModel(
///   amount: 99.99,
///   type: PaymentType.eftpos,
///   reference: 'TXN-123',
/// );
/// ```
@JsonSerializable()
class PaymentModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// Amount paid in this payment
  final double amount;

  /// Type of payment used
  @JsonKey(unknownEnumValue: PaymentType.unknown)
  final PaymentType type;

  /// Optional reference number (e.g., transaction ID, receipt number)
  final String? reference;

  PaymentModel({
    ObjectId? id,
    required this.amount,
    required this.type,
    this.reference,
  }) : id = id ?? ObjectId();

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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
class PostcodeModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
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
class ProductModel with DatabaseSerializable {
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Handle the name/description merge during deserialization
    final name = json['name'] as String?;
    final description = json['description'] as String?;
    json = Map<String, dynamic>.from(json);
    json['name'] = name ?? description ?? '';

    return _$ProductModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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
class RawMaterialsRegisterModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String? invoiceNumber;
  String? batchNumber;

  @NullableObjectIdConverter()
  ObjectId? fermentationRecordId;
  String materialType;
  int qtyIn;
  int qtyOut;

  @JsonKey(name: 'timestamp', includeIfNull: false)
  DateTime? _timestamp;

  DateTime get timestamp => _timestamp ?? id.dateTime;
  set timestamp(DateTime value) {
    _timestamp = value;
  }

  RawMaterialsRegisterModel(
      {ObjectId? id,
      this.invoiceNumber,
      this.batchNumber,
      this.fermentationRecordId,
      required this.materialType,
      required this.qtyIn,
      required this.qtyOut,
      DateTime? timestamp})
      : id = id ?? ObjectId(),
        _timestamp = timestamp;

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'fermentationRecordId'};
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
class SaleModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  ObjectId id;

  /// When the sale was completed
  DateTime timestamp;

  /// Due date for credit sales
  DateTime? dueDate;

  /// Status of the sale (paid or unpaid)
  @JsonKey(defaultValue: SaleStatus.unpaid, unknownEnumValue: SaleStatus.unpaid)
  SaleStatus status;

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
          .map((e) => e is CouponModel
              ? e
              : CouponModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map) {
      return json.values
          .map((e) => e is CouponModel
              ? e
              : CouponModel.fromJson(e as Map<String, dynamic>))
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
    this.dueDate,
    SaleStatus? status,
  })  : id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now(),
        coupons = _couponsFromJson(coupons),
        items = items ?? [],
        payments = payments ?? [],
        isMatesRates = isMatesRates ?? false,
        status = status ?? SaleStatus.unpaid;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'items': true, // List of SaleItemModel
        'payments': true, // List of PaymentModel
        'coupons': true, // List of CouponModel
      };

  @override
  Map<String, Function> get nestedTypes => {
        'items': SaleItemModel.fromJson,
        'payments': PaymentModel.fromJson,
        'coupons': CouponModel.fromJson,
      };
}

/// Status of a sale
enum SaleStatus {
  /// Sale is unpaid (has outstanding balance)
  unpaid,

  /// Sale is completed and fully paid
  paid
}

```

## sale_item

*File: lib/src/models/sale_item.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

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
class SaleItemModel with DatabaseSerializable {
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

  // No need to override objectIdFields since this model has no ObjectId fields
}

```

## still

*File: lib/src/models/still.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../json_helpers.dart';

part 'still.g.dart';

/// Represents a still in the distillery
@JsonSerializable()
class StillModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// The name of the still
  String name;

  /// The capacity of the still in liters
  double capacityLiters;

  /// A description of the still (type, manufacturer, etc)
  String description;

  /// Whether the still is currently active
  bool isActive;

  /// Date when the still was commissioned
  DateTime commissionedDate;

  /// Date when the still was decommissioned (if applicable)
  DateTime? decommissionedDate;

  StillModel({
    ObjectId? id,
    required this.name,
    required this.capacityLiters,
    this.description = '',
    this.isActive = true,
    required this.commissionedDate,
    this.decommissionedDate,
  }) : id = id ?? ObjectId();

  factory StillModel.fromJson(Map<String, dynamic> json) =>
      _$StillModelFromJson(json);
  Map<String, dynamic> toJson() => _$StillModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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
class StockJournalModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
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
class StockLocationModel with DatabaseSerializable {
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

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## stocktake

*File: lib/src/models/stocktake.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../json_helpers.dart';

part 'stocktake.g.dart';

@JsonSerializable()
class StocktakeModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  final String materialType;
  int currentStock;
  int newCount;
  final DateTime timestamp;

  StocktakeModel({
    ObjectId? id,
    required this.materialType,
    required this.currentStock,
    required this.newCount,
    DateTime? timestamp,
  })  : id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now();

  String get displayName {
    final names = {
      'raw_sugar': 'Raw Sugar',
      'white_sugar': 'White Sugar',
      'molasses': 'Molasses',
      'golden_syrup': 'Golden Syrup',
      'brown_sugar': 'Brown Sugar',
    };
    return names[materialType] ?? materialType;
  }

  int get difference => newCount - currentStock;

  factory StocktakeModel.fromJson(Map<String, dynamic> json) =>
      _$StocktakeModelFromJson(json);
  Map<String, dynamic> toJson() => _$StocktakeModelToJson(this);
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
class VolumeTransferredRecordModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  @ObjectIdConverter()
  ObjectId chargeId;

  @ObjectIdConverter()
  ObjectId washId;
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

  @override
  Set<String> get objectIdFields => {'_id', 'chargeId', 'washId'};
}

```

