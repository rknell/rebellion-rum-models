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
