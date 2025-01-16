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

  /// Primary description of the product
  String description;

  /// Current retail price in local currency
  double price;

  /// The discount we can give to friends of the distillery.
  double matesRatesPrice;

  /// Current stock level
  int stock;

  /// Product category (e.g., 'spirits', 'merchandise')
  ProductCategory category;

  /// Whether the product can be purchased online
  bool isAvailableOnline;

  /// Optional display name, if different from description
  String? name;

  /// List of image URLs associated with the product
  List<String> images;

  /// Detailed product description for online store
  String? longDescription;

  /// Brief product description for listings
  String? shortDescription;

  /// Product volume in milliliters (ml)
  int? volume;

  /// Product weight in kilograms (kg)
  double? weight;

  /// Alcohol by volume percentage
  double? abv;

  /// URL-friendly shortcut name
  String? shortcut;

  /// Whether the product is currently enabled for sale
  bool? enabled;

  ProductModel({
    required this.id,
    required this.barcode,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.isAvailableOnline = false,
    this.name,
    this.images = const [],
    this.longDescription,
    this.shortDescription,
    this.volume,
    this.weight,
    this.abv,
    this.shortcut,
    this.enabled,
    double? matesRatesPrice,
  }) : matesRatesPrice = matesRatesPrice ?? price * .8;

  // coverage:ignore-line
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
