# Models Documentation

This documentation is automatically generated from the model files.

## alcocalc_dilution_calculation

*File: lib/src/models/alcocalc_dilution_calculation.dart*

```dart
import 'package:alcocalc/alcocalc.dart' as alcocalc;
import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

// # Alcocalc Library API Documentation
//
// NOTE: This is a summary of the Alcocalc API. For complete documentation,
// please refer to the AlcoCalc_api.md file in the documentation directory.
//
// ## Major Changes in v2.0
//
// The library has been significantly refactored:
// 1. All functions are now static methods on the `Alcocalc` class
// 2. Result objects have more properties and better documentation
// 3. Sugar handling has been improved with the `SugarResult` class
//
// ## Key Static Methods
//
// - `Alcocalc.diluteByWeight`: Calculates dilution by weight using OIML tables
// - `Alcocalc.dilution`: Calculates a dilution with optional sugar additions
// - `Alcocalc.diluteToVolume`: Calculates a dilution to achieve a specific target volume
// - `Alcocalc.diluteToBottles`: Calculates a dilution to produce a specific number of bottles
// - `Alcocalc.calculateAlcoholAddition`: Calculates how much high-proof alcohol to add
// - `Alcocalc.correctedABV`: Corrects ABV for temperature using OIML tables
// - `Alcocalc.abvToAbw`: Converts ABV to ABW
// - `Alcocalc.litresOfAlcoholCalculation`: Calculates the total litres of pure alcohol (LALs)
//
// ## Key Classes
//
// - `DiluteByWeightResult`: Contains all calculated values from a dilution by weight operation
// - `DilutionResult`: Represents the complete result of a dilution operation
// - `SugarResult`: Represents a sugar addition in a dilution operation
// - `Sugars`: Defines a type of sugar to be used in dilution calculations
// - `AlcoholAdditionResult`: Contains the results of an alcohol addition calculation
//
// ## Usage Examples
//
// ```dart
// // Dilution by weight
// final result = Alcocalc.diluteByWeight(
//   startingABV: 0.60,      // 60% ABV
//   startingTemperature: 20, // 20°C
//   targetABV: 0.40,        // 40% ABV
//   startingWeight: 10.0,    // 10kg
// );
//
// // Dilution with sugar
// final sugars = [
//   Sugars(name: 'Simple syrup', specificGravity: 1.33, percentage: 0.05),
// ];
//
// final result = Alcocalc.dilution(
//   startingWeight: 10.0,
//   startingABV: 0.60,
//   startingTemperature: 20,
//   sugars: sugars,
//   targetABV: 0.40,
// );
//
// // Adding high-proof alcohol
// final result = Alcocalc.calculateAlcoholAddition(
//   currentWeight: 20.0,
//   currentABV: 0.35,
//   targetABV: 0.40,
//   additionABV: 0.962,
//   temperature: 20.0,
// );
// ```

part 'alcocalc_dilution_calculation.g.dart';

/// Represents a sugar to be used in dilution calculations.
@JsonSerializable()
class SugarInputModel {
  /// Name of the sugar
  final String name;

  /// Specific gravity of the sugar
  final double specificGravity;

  /// Percentage of the sugar in the solution (as a decimal)
  final double percentage;

  /// Gets the sugar content in degrees Brix (°Bx) by converting the specific gravity
  double get brix => alcocalc.Alcocalc.densityToBrix(specificGravity);

  SugarInputModel({
    required this.name,
    required this.specificGravity,
    required this.percentage,
  });

  /// Converts this model to the Alcocalc Sugars class
  alcocalc.Sugars toAlcoCalc() {
    return alcocalc.Sugars(
      name: name,
      specificGravity: specificGravity,
      percentage: percentage,
    );
  }

  /// Creates a SugarModel from an Alcocalc Sugars instance
  factory SugarInputModel.fromAlcoCalc(alcocalc.Sugars sugar) {
    return SugarInputModel(
      name: sugar.name,
      specificGravity: sugar.specificGravity,
      percentage: sugar.percentage,
    );
  }

  factory SugarInputModel.fromBrix({
    required String name,
    required double degreesBrix,
    required double percentage,
  }) {
    final specificGravity = alcocalc.Alcocalc.brixToDensity(degreesBrix);
    return SugarInputModel(
      name: name,
      specificGravity: specificGravity,
      percentage: percentage,
    );
  }

  factory SugarInputModel.fromJson(Map<String, dynamic> json) =>
      _$SugarInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$SugarInputModelToJson(this);
}

/// Represents the input parameters for a dilution calculation.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionInputModel {
  /// Initial weight in kilograms
  final double startingWeight;

  /// Initial alcohol by volume as a decimal (e.g., 0.40 for 40%)
  final double startingABV;

  /// Temperature in Celsius
  final double startingTemperature;

  /// Optional list of sugars to add to the dilution
  final List<SugarInputModel> sugars;

  /// Desired final alcohol by volume as a decimal
  final double targetABV;

  /// Reference to the product being diluted
  @NullableObjectIdConverter()
  final ObjectId? productId;

  /// Optional bottle size in liters for dilution calculations
  final double bottleSize;

  /// Timestamp of when this calculation was created
  final DateTime createdAt;

  AlcocalcDilutionInputModel({
    required this.startingWeight,
    required this.startingABV,
    required this.startingTemperature,
    this.sugars = const [],
    required this.targetABV,
    this.productId,
    this.bottleSize = 0.7,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AlcocalcDilutionInputModel.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionInputModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcocalcDilutionInputModelToJson(this);

  Set<String> get objectIdFields => {'_id', 'productId'};
}

/// Represents a sugar addition result in a dilution operation.
/// The equivalent AlcoCalc class is alcocalc.SugarResult
@JsonSerializable()
class SugarResultModel {
  /// Name of the sugar
  final String name;

  /// Weight of sugar to add in kilograms
  final double weight;

  /// Cumulative weight including this sugar and all previous sugars
  final double runningWeight;

  SugarResultModel(
      {required this.name, required this.weight, required this.runningWeight});

  /// Creates a SugarResultModel from an Alcocalc SugarResult instance
  factory SugarResultModel.fromAlcoCalcSugarResult(
      alcocalc.SugarResult result) {
    return SugarResultModel(
        name: result.name,
        weight: result.weight,
        runningWeight: result.runningWeight);
  }

  /// Converts this model to an Alcocalc Sugar instance
  alcocalc.SugarResult toAlcoCalcSugarResult() {
    return alcocalc.SugarResult(
        name: name, weight: weight, runningWeight: runningWeight);
  }

  factory SugarResultModel.fromJson(Map<String, dynamic> json) =>
      _$SugarResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SugarResultModelToJson(this);
}

/// Represents the complete result of a dilution calculation.
@JsonSerializable(explicitToJson: true)
class AlcocalcDilutionResultModel {
  /// Date when the calculation was performed
  final DateTime date;

  /// Initial weight in kilograms
  final double startingWeight;

  /// Temperature-corrected initial ABV
  final double correctedStartingABV;

  /// Litres of pure alcohol
  final double lals;

  /// Amount of water to add in litres
  final double additionalWaterLitres;

  /// Target weight after adding water
  final double targetWeightAfterWater;

  /// Calculated final ABV
  final double calculatedABV;

  /// Lower acceptable ABV limit
  final double acceptableABVLow;

  /// Upper acceptable ABV limit
  final double acceptableABVHigh;

  /// List of sugar additions
  final List<SugarResultModel> sugarResults;

  /// Target volume after dilution
  final double targetVolume;

  /// Expected number of bottles
  final double expectedBottles;

  /// Target final weight in kilograms after all additions
  final double targetFinalWeight;

  AlcocalcDilutionResultModel({
    required this.date,
    required this.startingWeight,
    required this.correctedStartingABV,
    required this.lals,
    required this.additionalWaterLitres,
    required this.targetWeightAfterWater,
    required this.calculatedABV,
    required this.acceptableABVLow,
    required this.acceptableABVHigh,
    required this.sugarResults,
    required this.targetVolume,
    required this.expectedBottles,
    required this.targetFinalWeight,
  });

  /// Creates an AlcocalcDilutionResultModel from an Alcocalc DilutionResult instance
  factory AlcocalcDilutionResultModel.fromAlcoCalc(
      alcocalc.DilutionResult result) {
    return AlcocalcDilutionResultModel(
      date: result.date,
      startingWeight: result.startingWeight,
      correctedStartingABV: result.correctedStartingABV,
      lals: result.lals,
      additionalWaterLitres: result.additionalWaterLitres,
      targetWeightAfterWater: result.targetWeightAfterWater,
      calculatedABV: result.calculatedABV,
      acceptableABVLow: result.acceptableABVLow,
      acceptableABVHigh: result.acceptableABVHigh,
      sugarResults: result.sugarResults
          .map((s) => SugarResultModel.fromAlcoCalcSugarResult(s))
          .toList(),
      targetVolume: result.targetVolume,
      expectedBottles: result.expectedBottles,
      targetFinalWeight: result.targetFinalWeight,
    );
  }

  /// Creates an Alcocalc DilutionResult from this model
  alcocalc.DilutionResult toAlcoCalc() {
    return alcocalc.DilutionResult(
      startingWeight: startingWeight,
      correctedStartingABV: correctedStartingABV,
      lals: lals,
      additionalWaterLitres: additionalWaterLitres,
      targetWeightAfterWater: targetWeightAfterWater,
      calculatedABV: calculatedABV,
      sugarResults: sugarResults.map((s) => s.toAlcoCalcSugarResult()).toList(),
      targetVolume: targetVolume,
      expectedBottles: expectedBottles,
      targetFinalWeight: targetFinalWeight,
    );
  }

  factory AlcocalcDilutionResultModel.fromJson(Map<String, dynamic> json) =>
      _$AlcocalcDilutionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcocalcDilutionResultModelToJson(this);
}

/// Represents the result of an alcohol addition calculation.
@JsonSerializable(explicitToJson: true)
class AlcoholAdditionResultModel {
  /// The current weight of the original liquid in kilograms
  final double currentWeight;

  /// The original ABV of the liquid as a decimal
  final double currentABV;

  /// The desired target ABV as a decimal
  final double targetABV;

  /// The ABV of the alcohol being added as a decimal
  final double additionABV;

  /// The temperature in Celsius at which the calculation is performed
  final double temperature;

  /// ABV corrected for temperature effects
  final double correctedCurrentABV;

  /// ABV of the addition corrected for temperature effects
  final double correctedAdditionABV;

  /// The density of the original liquid in kg/L
  final double currentDensity;

  /// The density of the alcohol being added in kg/L
  final double additionDensity;

  /// The density of the resulting mixture in kg/L
  final double targetDensity;

  /// The volume of the original liquid in liters
  final double currentVolume;

  /// The volume of pure alcohol in the original liquid in liters
  final double currentAlcoholVolume;

  /// The volume of alcohol to be added in liters
  final double additionVolume;

  /// The weight of high-proof alcohol that needs to be added in kilograms
  final double requiredAlcoholWeight;

  /// The total weight after addition in kilograms
  final double finalWeight;

  /// The total volume after addition in liters
  final double finalVolume;

  /// Liters of Absolute Alcohol (LALs) added
  final double lals;

  /// Date when the calculation was performed
  final DateTime createdAt;

  AlcoholAdditionResultModel({
    required this.currentWeight,
    required this.currentABV,
    required this.targetABV,
    required this.additionABV,
    required this.temperature,
    required this.correctedCurrentABV,
    required this.correctedAdditionABV,
    required this.currentDensity,
    required this.additionDensity,
    required this.targetDensity,
    required this.currentVolume,
    required this.currentAlcoholVolume,
    required this.additionVolume,
    required this.requiredAlcoholWeight,
    required this.finalWeight,
    required this.finalVolume,
    required this.lals,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Creates an AlcoholAdditionResultModel from an Alcocalc AlcoholAdditionResult instance
  factory AlcoholAdditionResultModel.fromAlcoCalc(
    alcocalc.AlcoholAdditionResult result,
  ) {
    return AlcoholAdditionResultModel(
      currentWeight: result.currentWeight,
      currentABV: result.currentABV,
      targetABV: result.targetABV,
      additionABV: result.additionABV,
      temperature: result.temperature,
      correctedCurrentABV: result.correctedCurrentABV,
      correctedAdditionABV: result.correctedAdditionABV,
      currentDensity: result.currentDensity,
      additionDensity: result.additionDensity,
      targetDensity: result.targetDensity,
      currentVolume: result.currentVolume,
      currentAlcoholVolume: result.currentAlcoholVolume,
      additionVolume: result.additionVolume,
      requiredAlcoholWeight: result.requiredAlcoholWeight,
      finalWeight: result.finalWeight,
      finalVolume: result.finalVolume,
      lals: result.lals,
    );
  }

  factory AlcoholAdditionResultModel.fromJson(Map<String, dynamic> json) =>
      _$AlcoholAdditionResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$AlcoholAdditionResultModelToJson(this);
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
class BulkStorageRegisterItemModel extends DatabaseSerializable {
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
    if (fromDistillationId != null) {
      if (toVesselId != null) return BulkStorageMovementType.fromStill;
      // If no destination and feints destroyed, it's still feints destroyed
      if (feintsDestroyed) return BulkStorageMovementType.feintsDestroyed;
    }

    if (fromVesselId != null) {
      if (toDistillationId != null) return BulkStorageMovementType.toStill;
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
  @NullableObjectIdConverter()
  @JsonKey(name: 'fromChargeId')
  ObjectId? fromDistillationId;

  /// Reference to the source vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromVesselId;

  /// Reference to the destination vessel (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toVesselId;

  /// Reference to the destination charge (if applicable)
  @NullableObjectIdConverter()
  @JsonKey(name: 'toChargeId')
  ObjectId? toDistillationId;

  /// Reference to the destination packaging (if applicable)
  @NullableObjectIdConverter()
  ObjectId? toPackagingId;

  /// Reference to the source packaging (if applicable)
  @NullableObjectIdConverter()
  ObjectId? fromPackagingId;

  /// Reference to the product being moved
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Timestamp extracted from the document's ObjectId
  DateTime get timestamp => id.dateTime;

  @override
  Set<String> get objectIdFields => {
        '_id',
        'fromChargeId',
        'fromPackagingId',
        'fromVesselId',
        'productId',
        'toChargeId',
        'toPackagingId',
        'toVesselId',
      };

  BulkStorageRegisterItemModel({
    super.id,
    this.lalsCalculation,
    this.legacyLals,
    this.feintsDestroyed = false,
    this.wastage = false,
    this.isStocktake = false,
    this.notes,
    this.fromDistillationId,
    this.fromVesselId,
    this.toVesselId,
    this.toDistillationId,
    this.toPackagingId,
    this.fromPackagingId,
    this.productId,
  }) : assert(lalsCalculation != null || legacyLals != null,
            'Either lalsCalculation or legacyLals must be provided');

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
  @override
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemModelToJson(this);
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
class BulkStorageVesselModel extends DatabaseSerializable {
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
  @NullableObjectIdConverter()
  ObjectId? productId;

  /// Whether the vessel needs a stocktake before operations
  bool needsStocktake;

  BulkStorageVesselModel({
    super.id,
    this.barcode = '',
    String? name,
    this.capacity = 0,
    this.currentLals = 0,
    this.status = BulkStorageVesselStatus.active,
    this.productId,
    this.needsStocktake = false,
  }) : _name = name;

  /// Get the remaining LALs in the vessel
  double get remainingLALs => currentLals;

  factory BulkStorageVesselModel.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageVesselModelFromJson(json);
  @override
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

```

## coupon

*File: lib/src/models/coupon.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'coupon.g.dart';

@JsonSerializable()
class CouponModel extends DatabaseSerializable {
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
    super.id,
    required this.code,
    required this.description,
    required this.amount,
    required this.email,
    this.phone,
    this.redeemed,
    double? remainingValue,
  }) : _remainingValue = remainingValue;

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
  @override
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
      {super.id,
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
      : preferences = preferences ?? <CustomerPreferences>{};

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## delivery_authority

*File: lib/src/models/delivery_authority.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthorityModel extends DatabaseSerializable {
  final String deliveryAuthorityNumber;
  final double lals;

  DeliveryAuthorityModel({
    super.id,
    required this.deliveryAuthorityNumber,
    required this.lals,
  });

  factory DeliveryAuthorityModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAuthorityModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DeliveryAuthorityModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## distillation_record

*File: lib/src/models/distillation_record.dart*

```dart
import 'package:alcocalc/alcocalc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_lals_calculation.dart';
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
class DistillationRecordModel extends DatabaseSerializable {
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

  GinStillStocktakeModel? ginStillStocktake;

  DistillationRecordModel({
    super.id,
    this.stillUsed = '',
    DateTime? startTime,
    this.status = DistillationStatus.inProgress,
    this.feintsAdded = 0,
    this.lalsCharged = 0,
    this.totalLALsCharged = 0,
    this.totalLALsYield = 0,
    List<NoteModel>? notes,
  })  : startTime = startTime ?? DateTime.now(),
        notes = notes ?? [];

  factory DistillationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$DistillationRecordModelFromJson(json);
  @override
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
class NoteModel {
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

/// Represents a stocktake measurement for a gin still
///
/// This model captures the key measurements needed for inventory tracking
/// of spirits in a gin still, including the liquid height, alcohol by volume,
/// and temperature (defaulting to 20°C if not specified).
@JsonSerializable()
class GinStillStocktakeModel {
  /// The height of the liquid in the still
  final double height;

  /// The alcohol by volume (ABV) as a decimal (e.g., 0.40 for 40%)
  final double abv;

  /// The temperature of the liquid in Celsius
  /// Defaults to 20°C if not specified
  final double temperature;

  final double volume;

  static double currentVolume(double height) {
    var stillWidth = 70; //cm
    var stillHeight = 61; //cm
    // Calculate the volume based on the "head gap" measurement
    // The height field represents the gap between liquid and top of vessel

    // Calculate the actual liquid height by subtracting the head gap from still height
    var liquidHeight = stillHeight - height;

    // Ensure the liquid height is not negative
    if (liquidHeight < 0) {
      return 0;
    }

    // Calculate the volume using the formula for a cylinder: V = π * r² * h
    // where r is the radius (stillWidth/2) and h is the liquid height

    // Convert width to radius in cm
    var radius = stillWidth / 2;

    // Calculate the total volume of the cylinder in cubic cm
    var liquidVolumeCm3 = 3.14159 * radius * radius * liquidHeight;

    // Convert to liters (1000 cm³ = 1 liter)
    return liquidVolumeCm3 / 1000;
  }

  final AlcocalcLalsCalculation lals;

  GinStillStocktakeModel({
    required this.height,
    required this.abv,
    this.temperature = 20,
  })  : volume = currentVolume(height),
        lals = AlcocalcLalsCalculation(
            weight: Alcocalc.abvToAbw(abv) * currentVolume(height),
            abv: abv,
            temperature: temperature);

  factory GinStillStocktakeModel.fromJson(Map<String, dynamic> json) =>
      _$GinStillStocktakeModelFromJson(json);
  Map<String, dynamic> toJson() => _$GinStillStocktakeModelToJson(this);
}

```

## eftpos_terminal

*File: lib/src/models/eftpos_terminal.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'eftpos_terminal.g.dart';

@JsonSerializable()
class EftposTerminalModel extends DatabaseSerializable {
  final String name;
  final String secret;
  final DateTime createdAt;
  final DateTime lastUsed;

  EftposTerminalModel({
    super.id,
    required this.name,
    required this.secret,
    DateTime? createdAt,
    DateTime? lastUsed,
  })  : createdAt = createdAt ?? DateTime.now(),
        lastUsed = lastUsed ?? DateTime.now();

  factory EftposTerminalModel.fromJson(Map<String, dynamic> json) =>
      _$EftposTerminalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EftposTerminalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## excise_return

*File: lib/src/models/excise_return.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'excise_return.g.dart';

/// Represents an excise duty return for regulatory compliance.
@JsonSerializable()
class ExciseReturnModel extends DatabaseSerializable {
  /// Total volume of spirits in LALs (Liters of Absolute Alcohol)
  final double totalLals;

  /// Whether remission has been applied to this return
  final bool remissionApplied;

  String? referenceNumber;

  ExciseReturnModel({
    super.id,
    required this.totalLals,
    required this.remissionApplied,
  });

  factory ExciseReturnModel.fromJson(Map<String, dynamic> json) =>
      _$ExciseReturnModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ExciseReturnModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## fermentation_record

*File: lib/src/models/fermentation_record.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
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
class FermentationRecordModel extends DatabaseSerializable {
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
    super.id,
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
  }) : fermentationProgress = fermentationProgress ?? [];

  factory FermentationRecordModel.fromJson(Map<String, dynamic> json) =>
      _$FermentationRecordModelFromJson(json);
  @override
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
class OrderModel extends DatabaseSerializable {
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
  String? paymentMethod;

  /// Payment receipt details
  Map<String, dynamic>? paymentReceipt;

  /// Shipping method (e.g., 'FREEDELIVERY')
  String? shippingMethod;

  /// Shipping receipt details
  Map<String, dynamic>? shippingReceipt;

  /// Total quoted price for the order
  double totalQuote;

  OrderModel({
    super.id,
    required this.customer,
    required this.date,
    required this.items,
    required this.orderNumber,
    required this.paymentMethod,
    required this.totalQuote,
    this.paymentReceipt,
    this.shippingMethod,
    this.shippingReceipt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  @override
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
import 'package:rebellion_rum_models/src/models/alcocalc_dilution_calculation.dart';

part 'packaging_run_item.g.dart';

/// Status of a packaging run
/// Note: Introduced in v2.0.0 replacing string-based exciseReturn field
/// Migration path:
/// - Previous exciseReturn="": maps to inProgress
/// - Previous exciseReturn="W12345": maps to complete
/// - Previous exciseReturn=null: maps to inProgress
/// - All other values map to awaitingExcise
///
/// Enhanced in v3.0.0 to add excised status
enum PackagingRunStatus {
  /// Run is in progress
  inProgress,

  /// Run is complete but awaiting excise return
  awaitingExcise,

  /// Run is complete with excise return
  complete,

  /// Run is excised (final state)
  excised
}

@JsonSerializable()
class PackagingRunItemModel extends DatabaseSerializable {
  /// Barcode of the product being packaged
  String? productBarcode;

  /// Size of individual units (typically 700ml, expressed in litres as 0.7)
  double? unitSize;

  /// Alcohol strength (ABV) expressed as 0.50 for 50%
  double? strength;

  /// Number of units packaged
  double? unitsPackaged;

  /// Losses during packaging in LALs
  double? packagingLosses;

  /// Remaining product after packaging in LALs
  double? remaining;

  /// Volume available before packaging in LALs
  double? volumeAvailable;

  /// Volume remaining after packaging in LALs
  double? volumeRemaining;

  /// The initial LALs calculation for the packaging run
  AlcocalcDilutionResultModel? estimatedDilution;

  /// The actual production dilution calculation, performed when you have a known weight and abv
  AlcocalcDilutionResultModel? productionDilution;

  /// ABV reading taken after dilution
  double? abvReading;

  /// Target number of bottles to fill, compare to units packaged and ensure its within 1.5% plus or minus
  double targetBottles;

  /// The timestamp of the packaging run
  /// If not set, falls back to the ObjectId timestamp
  DateTime? timestamp;

  /// The date when this packaging run was marked as complete
  DateTime? completionDate;

  /// Get the effective timestamp, falling back to ObjectId timestamp if not set
  DateTime get effectiveTimestamp => timestamp ?? id.dateTime;

  /// Default value of inProgress aligns with the migration path where both
  /// empty strings and null values in the legacy exciseReturn field map to inProgress,
  /// making it the most appropriate default for new records and migration cases.
  @JsonKey(unknownEnumValue: PackagingRunStatus.excised)
  PackagingRunStatus status;

  /// Excise return reference - either ObjectId or string identifier
  @NullableObjectIdConverter()
  ObjectId? exciseReturn;

  /// Note explaining discrepancy when actual bottles != expected bottles +- 1.5%
  String? discrepancyNote;

  bool isConfirmedSugars;

  double get lals =>
      ((unitSize ?? 0) / 1000) * (unitsPackaged ?? 0) * (strength ?? 0);

  PackagingRunItemModel(
      {super.id,
      this.productBarcode,
      this.unitSize,
      this.strength,
      this.unitsPackaged,
      this.packagingLosses,
      this.remaining,
      this.volumeAvailable,
      this.volumeRemaining,
      this.targetBottles = 0,
      this.status = PackagingRunStatus.inProgress,
      this.estimatedDilution,
      this.productionDilution,
      this.abvReading,
      this.exciseReturn,
      this.timestamp,
      this.discrepancyNote,
      this.completionDate,
      this.isConfirmedSugars = false});

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## payment

*File: lib/src/models/payment.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
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
class PaymentModel extends DatabaseSerializable {
  /// Amount paid in this payment
  final double amount;

  /// Type of payment used
  @JsonKey(unknownEnumValue: PaymentType.unknown)
  final PaymentType type;

  /// Optional reference number (e.g., transaction ID, receipt number)
  final String? reference;

  PaymentModel({
    super.id,
    required this.amount,
    required this.type,
    this.reference,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## payment_intent_request

*File: lib/src/models/payment_intent_request.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/shipping_quote_request_model.dart';

part 'payment_intent_request.g.dart';

/// Represents a request for creating a payment intent.
///
/// This model extends the ShippingQuoteRequestModel to include the shipping method
/// Given the shipping method, the items and the destination address, a quote
/// can be generated which will give the amount due - this is done server side
/// to avoid price manipulation.
///
/// Example:
/// ```dart
/// final request = PaymentIntentRequest(
///   address: destinationAddress,
///   items: {'product-123': 2, 'product-456': 1},
///   shippingMethod: 'express',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentIntentRequest extends ShippingQuoteRequestModel {
  final String shippingMethod;

  /// Creates a new payment intent request
  const PaymentIntentRequest({
    required super.address,
    required super.items,
    required this.shippingMethod,
  });

  /// Creates an instance from a JSON object
  factory PaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentRequestFromJson(json);

  /// Converts this instance to a JSON object
  @override
  Map<String, dynamic> toJson() => _$PaymentIntentRequestToJson(this);
}

```

## postcode

*File: lib/src/models/postcode.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
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
class PostcodeModel extends DatabaseSerializable {
  /// Four-digit Australian postcode
  final String postcode;

  /// Suburb or locality name
  final String locality;

  /// State or territory code (e.g., 'VIC', 'NSW')
  final String state;

  /// Delivery zone classification for shipping
  final String combined;

  PostcodeModel({
    super.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.combined,
  });

  factory PostcodeModel.fromJson(Map<String, dynamic> json) =>
      _$PostcodeModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$PostcodeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## product

*File: lib/src/models/product.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/alcocalc_dilution_calculation.dart';

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
class ProductModel extends DatabaseSerializable {
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

  /// Whether the product is archived (soft deleted)
  bool isArchived;

  /// Recipe information for producing this product
  ProductRecipe? recipe;

  ProductModel({
    super.id,
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
    this.isArchived = false,
    this.recipe,
  })  : volume = volume ?? 700.0,
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
  @override
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

/// Represents a recipe for a product, including target ABV and sugar additions.
///
/// This class is used in production to standardize the dilution and flavor process
/// for spirits and liqueurs. It contains the target ABV and any sugar additions
/// required for the final product.
@JsonSerializable(explicitToJson: true)
class ProductRecipe {
  /// Target alcohol by volume percentage for the final product
  final double targetAbv;

  /// List of sugar additions for the recipe (for liqueurs)
  final List<SugarInputModel> sugars;

  /// Creates a new product recipe
  ProductRecipe({
    required this.targetAbv,
    this.sugars = const [],
  });

  /// Creates an instance from a JSON object
  factory ProductRecipe.fromJson(Map<String, dynamic> json) =>
      _$ProductRecipeFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ProductRecipeToJson(this);
}

```

## raw_material_type

*File: lib/src/models/raw_material_type.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'raw_material_type.g.dart';

/// Represents a type of raw material used in distillation.
///
/// This model serves as a lookup table between sugar type and specific gravity,
/// which is needed for tax calculations and tracking raw materials.
///
/// Example:
/// ```dart
/// final molasses = RawMaterialTypeModel(
///   name: 'Molasses',
///   specificGravity: 1.4,
/// );
/// ```
@JsonSerializable()
class RawMaterialTypeModel extends DatabaseSerializable {
  /// The name of the raw material type (e.g., Molasses, Sugar Cane)
  String name;

  /// The specific gravity of the raw material
  /// Used in calculations for conversion rates and tax purposes
  double specificGravity;

  RawMaterialTypeModel({
    super.id,
    required this.name,
    required this.specificGravity,
  });

  factory RawMaterialTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialTypeModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RawMaterialTypeModelToJson(this);

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
class RawMaterialsRegisterModel extends DatabaseSerializable {
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
      {super.id,
      this.invoiceNumber,
      this.batchNumber,
      this.fermentationRecordId,
      required this.materialType,
      required this.qtyIn,
      required this.qtyOut,
      DateTime? timestamp})
      : _timestamp = timestamp;

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'fermentationRecordId'};
}

```

## sale

*File: lib/src/models/sale.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
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
class SaleModel extends DatabaseSerializable {
  /// When the sale was completed
  @JsonKey(name: 'timestamp')
  dynamic _timestamp;

  DateTime get timestamp {
    return _timestamp is String
        ? DateTime.tryParse(_timestamp)
        : _timestamp ?? id.dateTime;
  }

  set timestamp(DateTime time) {
    _timestamp = time;
  }

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
    super.id,
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
  })  : _timestamp = timestamp,
        coupons = _couponsFromJson(coupons),
        items = items ?? [],
        payments = payments ?? [],
        isMatesRates = isMatesRates ?? false,
        status = status ?? SaleStatus.unpaid;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SaleModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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

  // No need to override objectIdFields since this model has no ObjectId fields
}

```

## shipping_quote_request_model

*File: lib/src/models/shipping_quote_request_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_destination_address_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_package_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_sender_address_model.dart';

part 'shipping_quote_request_model.g.dart';

/// Represents a request for shipping quotes.
///
/// This model wraps a destination address and a map of items with their quantities.
/// It's used to request shipping rate quotes for a specific address and set of items.
///
/// Example:
/// ```dart
/// final request = ShippingQuoteRequestModel(
///   address: destinationAddress,
///   items: {'product-123': 2, 'product-456': 1},
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class ShippingQuoteRequestModel {
  /// The destination address for the shipping quote
  final StartShipItRateDestinationAddressModel address;

  /// Map of item identifiers to quantities
  /// Key: Product/item identifier
  /// Value: Quantity of the item
  final Map<String, int> items;

  /// Calculates the total number of items by summing all quantities in the items map
  int get totalItems => items.values.fold(0, (sum, quantity) => sum + quantity);

  List<StartShipItRatePackageModel> get packages {
    // Calculate how many packages we need based on the total items
    // Each package can hold up to 6 items
    final int totalItems = this.totalItems;
    final int packagesNeeded = (totalItems / 6).ceil();

    // Create the list of packages
    final List<StartShipItRatePackageModel> result = [];

    int remainingItems = totalItems;

    // Create each package with the appropriate number of items
    for (int i = 0; i < packagesNeeded; i++) {
      // For each package, determine how many items it will contain
      // (up to 6 items per package)
      final int itemsInPackage = remainingItems >= 6 ? 6 : remainingItems;

      result.add(
        StartShipItRatePackageModel(
          weight: itemsInPackage.toDouble() *
              1.4, // Weight based on number of items
          length: 0.29,
          width: 0.25,
          height: 0.20,
        ),
      );

      remainingItems -= itemsInPackage;
    }

    return result;
  }

  StartShipItRateSenderAddressModel get sender =>
      StartShipItRateSenderAddressModel(
          street: "Unit 27/3 Octal St",
          suburb: "Yatala",
          state: "QLD",
          postCode: "4207",
          countryCode: "AU");

  const ShippingQuoteRequestModel({
    required this.address,
    required this.items,
  });

  /// Creates an instance from a JSON object
  factory ShippingQuoteRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingQuoteRequestModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$ShippingQuoteRequestModelToJson(this);
}

```

## startshipit_error_model

*File: lib/src/models/startshipit_error_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'startshipit_error_model.g.dart';

/// Represents an error from StartShipIt API
///
/// Contains information about the error, including the error message
/// and detailed exception information.
///
/// Example:
/// ```dart
/// final error = StartShipItErrorModel(
///   message: 'Invalid address',
///   details: 'The provided postal code is not valid for the country',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItErrorModel {
  /// Error message
  final String message;

  /// Detailed exception information
  final String details;

  const StartShipItErrorModel({
    required this.message,
    required this.details,
  });

  /// Creates an instance from a JSON object
  factory StartShipItErrorModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItErrorModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItErrorModelToJson(this);
}

```

## startshipit_get_rates_request_model

*File: lib/src/models/startshipit_get_rates_request_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_destination_address_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_package_model.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_sender_address_model.dart';

part 'startshipit_get_rates_request_model.g.dart';

/// Represents a request to get shipping rates from StartShipIt.
///
/// Contains sender and destination addresses, package information,
/// and currency code.
///
/// Example:
/// ```dart
/// final request = StartShipItGetRatesRequestModel(
///   destination: destinationAddress,
///   packages: [package1, package2],
///   currency: 'AUD',
///   sender: senderAddress,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class StartShipItGetRatesRequestModel {
  /// Sender address details (Rate Sender Address Model)
  /// If not provided, Pickup Address details from the Settings are used
  final StartShipItRateSenderAddressModel? sender;

  /// Shipping address details (Rate Destination Address Model)
  final StartShipItRateDestinationAddressModel destination;

  /// A list of packages with weight and dimensions (Rate Package Model)
  final List<StartShipItRatePackageModel> packages;

  /// Currency code for the order value (max length: 3) e.g. AUD
  final String currency;

  const StartShipItGetRatesRequestModel({
    this.sender,
    required this.destination,
    required this.packages,
    this.currency = "AUD",
  });

  /// Creates an instance from a JSON object
  factory StartShipItGetRatesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItGetRatesRequestModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItGetRatesRequestModelToJson(this);
}

```

## startshipit_get_rates_response_model

*File: lib/src/models/startshipit_get_rates_response_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/models/startshipit_rate_model.dart';

part 'startshipit_get_rates_response_model.g.dart';

/// Represents a response from the StartShipIt Get Rates API.
///
/// Contains a list of available shipping rates, success status,
/// and any errors that occurred during the request.
///
/// Example:
/// ```dart
/// final response = StartShipItGetRatesResponseModel(
///   rates: [rate1, rate2],
///   success: true,
///   errors: [],
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItGetRatesResponseModel {
  /// A list of available shipping rates (Rate Model)
  final List<StartShipItRateModel> rates;

  /// Determines whether the request was successfully submitted
  final bool success;

  const StartShipItGetRatesResponseModel(
      {required this.rates, required this.success});

  /// Creates an instance from a JSON object
  factory StartShipItGetRatesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItGetRatesResponseModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItGetRatesResponseModelToJson(this);
}

```

## startshipit_rate_destination_address_model

*File: lib/src/models/startshipit_rate_destination_address_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_destination_address_model.g.dart';

/// Represents a destination address for StartShipIt rate calculations.
///
/// Contains all required address components for shipping rate calculations,
/// including street, suburb, city, state, post code, and country code.
///
/// Example:
/// ```dart
/// final destinationAddress = StartShipItRateDestinationAddressModel(
///   street: '123 Main St',
///   suburb: 'Richmond',
///   city: 'Melbourne',
///   state: 'VIC',
///   postCode: '3121',
///   countryCode: 'AU',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateDestinationAddressModel {
  /// Street number and name of the delivery address
  final String street;

  /// Suburb of the delivery address
  final String suburb;

  /// City of the delivery address
  final String city;

  /// State, regional, provincial or county name of the delivery address
  final String state;

  /// Postal or zip code of the delivery address
  final String postCode;

  /// The country code of the delivery address
  final String countryCode;

  const StartShipItRateDestinationAddressModel({
    required this.street,
    required this.suburb,
    required this.state,
    required this.postCode,
    this.countryCode = 'AU',
  }) : city = suburb;

  /// Creates an instance from a JSON object
  factory StartShipItRateDestinationAddressModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItRateDestinationAddressModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItRateDestinationAddressModelToJson(this);
}

```

## startshipit_rate_model

*File: lib/src/models/startshipit_rate_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_model.g.dart';

/// Represents a shipping rate from StartShipIt.
///
/// Contains information about the carrier service, including service name,
/// service code, and total price.
///
/// Example:
/// ```dart
/// final rate = StartShipItRateModel(
///   serviceName: 'Express Post',
///   serviceCode: 'AUS_EXPRESS',
///   totalPrice: 15.50,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateModel {
  /// Description of the carrier service
  final String serviceName;

  /// Carrier service/product code
  final String serviceCode;

  /// Price of service
  final double totalPrice;

  const StartShipItRateModel({
    required this.serviceName,
    required this.serviceCode,
    required this.totalPrice,
  });

  /// Creates an instance from a JSON object
  factory StartShipItRateModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItRateModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItRateModelToJson(this);
}

```

## startshipit_rate_package_model

*File: lib/src/models/startshipit_rate_package_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_package_model.g.dart';

/// Represents a package for StartShipIt rate calculations.
///
/// Contains all required package dimensions and weight for shipping rate calculations,
/// including weight, height, width, and length.
///
/// Example:
/// ```dart
/// final package = StartShipItRatePackageModel(
///   weight: 1.5,
///   height: 0.3,
///   width: 0.25,
///   length: 0.4,
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRatePackageModel {
  /// Physical weight of the parcel in kilograms (kg)
  final double weight;

  /// Height of the parcel in meters (m)
  final double? height;

  /// Width of the parcel in meters (m)
  final double? width;

  /// Length of the parcel in meters (m)
  final double? length;

  const StartShipItRatePackageModel({
    required this.weight,
    this.height,
    this.width,
    this.length,
  });

  /// Creates an instance from a JSON object
  factory StartShipItRatePackageModel.fromJson(Map<String, dynamic> json) =>
      _$StartShipItRatePackageModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() => _$StartShipItRatePackageModelToJson(this);
}

```

## startshipit_rate_sender_address_model

*File: lib/src/models/startshipit_rate_sender_address_model.dart*

```dart
import 'package:json_annotation/json_annotation.dart';

part 'startshipit_rate_sender_address_model.g.dart';

/// Represents a sender address for StartShipIt rate calculations.
///
/// Contains all required address components for shipping rate calculations,
/// including street, suburb, city, state, post code, and country code.
///
/// Example:
/// ```dart
/// final senderAddress = StartShipItRateSenderAddressModel(
///   street: '123 Main St',
///   suburb: 'Richmond',
///   city: 'Melbourne',
///   state: 'VIC',
///   postCode: '3121',
///   countryCode: 'AU',
/// );
/// ```
@JsonSerializable(fieldRename: FieldRename.snake)
class StartShipItRateSenderAddressModel {
  /// Street number and name of the sender address
  final String street;

  /// Suburb of the sender address
  final String suburb;

  /// City of the sender address
  final String city;

  /// State, regional, provincial or county name of the sender address
  final String state;

  /// Postal or zip code of the sender address
  final String postCode;

  /// The country code of the sender address
  final String countryCode;

  const StartShipItRateSenderAddressModel({
    required this.street,
    required this.suburb,
    required this.state,
    required this.postCode,
    required this.countryCode,
  }) : city = suburb;

  /// Creates an instance from a JSON object
  factory StartShipItRateSenderAddressModel.fromJson(
          Map<String, dynamic> json) =>
      _$StartShipItRateSenderAddressModelFromJson(json);

  /// Converts this instance to a JSON object
  Map<String, dynamic> toJson() =>
      _$StartShipItRateSenderAddressModelToJson(this);
}

```

## still

*File: lib/src/models/still.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'still.g.dart';

/// Represents a still in the distillery
@JsonSerializable()
class StillModel extends DatabaseSerializable {
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
    super.id,
    required this.name,
    required this.capacityLiters,
    this.description = '',
    this.isActive = true,
    required this.commissionedDate,
    this.decommissionedDate,
  });

  factory StillModel.fromJson(Map<String, dynamic> json) =>
      _$StillModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StillModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## stock_journal

*File: lib/src/models/stock_journal.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations and packaging operations.
@JsonSerializable()
class StockJournalModel extends DatabaseSerializable {
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
    super.id,
    required this.barcode,
    required this.type,
    required this.from,
    required this.to,
    required this.qty,
  });

  factory StockJournalModel.fromJson(Map<String, dynamic> json) =>
      _$StockJournalModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StockJournalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## stock_location

*File: lib/src/models/stock_location.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_location.g.dart';

/// Represents a physical storage location for stock items.
///
/// Stock locations are used to track where products and materials are stored
/// within the facility. Each location has a unique identifier and specific flags
/// indicating its type and purpose.
@JsonSerializable()
class StockLocationModel extends DatabaseSerializable {
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
    super.id,
    required this.name,
    required this.barcode,
    required this.isBondStore,
    required this.isRetail,
    required this.isAvailableOnline,
    required this.isWarehouse,
    this.stockLevels,
  });

  factory StockLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StockLocationModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StockLocationModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

```

## stocktake

*File: lib/src/models/stocktake.dart*

```dart
import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'stocktake.g.dart';

@JsonSerializable()
class StocktakeModel extends DatabaseSerializable {
  final String materialType;
  int currentStock;
  int newCount;
  final DateTime timestamp;

  StocktakeModel({
    super.id,
    required this.materialType,
    required this.currentStock,
    required this.newCount,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

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
  @override
  Map<String, dynamic> toJson() => _$StocktakeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
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
class VolumeTransferredRecordModel extends DatabaseSerializable {
  @ObjectIdConverter()
  ObjectId chargeId;

  @ObjectIdConverter()
  ObjectId washId;
  double volume;
  double lals;

  VolumeTransferredRecordModel({
    super.id,
    required this.chargeId,
    required this.washId,
    required this.volume,
    required this.lals,
  });

  factory VolumeTransferredRecordModel.fromJson(Map<String, dynamic> json) =>
      _$VolumeTransferredRecordModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VolumeTransferredRecordModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'chargeId', 'washId'};
}

```

