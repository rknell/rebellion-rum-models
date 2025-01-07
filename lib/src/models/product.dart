import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

/// Represents a product in the Rebellion Rum inventory system.
///
/// Products can be either physical items (like bottles of rum) or digital items.
/// Each product has a unique identifier, barcode, and various attributes that
/// describe its characteristics and availability.
///
/// Example:
/// ```dart
/// final product = Product(
///   id: '123',
///   barcode: '9876543210',
///   description: 'Premium Dark Rum',
///   price: 49.99,
///   stock: 100,
///   category: 'spirits',
///   isAvailableOnline: true,
/// );
/// ```
@JsonSerializable()
class Product {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Unique barcode identifier for the product
  final String barcode;

  /// Primary description of the product
  final String description;

  /// Current retail price in local currency
  final double price;

  /// Current stock level
  final int stock;

  /// Product category (e.g., 'spirits', 'merchandise')
  final String category;

  /// Whether the product can be purchased online
  final bool isAvailableOnline;

  /// Optional display name, if different from description
  final String? name;

  /// List of image URLs associated with the product
  final List<String> images;

  /// Detailed product description for online store
  final String? longDescription;

  /// Brief product description for listings
  final String? shortDescription;

  /// Product volume in milliliters (ml)
  final int? volume;

  /// Product weight in kilograms (kg)
  final double? weight;

  /// Alcohol by volume percentage
  final double? abv;

  /// URL-friendly shortcut name
  final String? shortcut;

  /// Whether the product is currently enabled for sale
  final bool? enabled;

  const Product({
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
  });

  // coverage:ignore-line
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
