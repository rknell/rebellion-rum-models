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

/// Represents an award received by a product
@JsonSerializable()
class Award {
  /// Unique identifier for the award
  final int id;

  /// Award level (e.g., "Bronze", "Silver", "Gold")
  final String level;

  /// Name of the competition where the award was received
  final String competition;

  /// Year the award was received
  final int year;

  Award({
    required this.id,
    required this.level,
    required this.competition,
    required this.year,
  });

  factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);
  Map<String, dynamic> toJson() => _$AwardToJson(this);
}

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

  /// Product volume in milliliters (ml)
  double volume;

  /// Product weight in kilograms (kg)
  double? weight;

  /// Alcohol by volume percentage
  double abv;

  /// Percentage of Australian content
  double percentAustralian;

  /// Whether the product is currently enabled for sale
  bool? enabled;

  /// Whether the product is archived (soft deleted)
  bool isArchived;

  /// Recipe information for producing this product
  ProductRecipe? recipe;

  /// URL-friendly slug for the product
  String? slug;

  /// Whether the product is featured on the homepage or in special sections
  bool? isFeatured;

  /// Hero image URL for product showcase pages
  String? heroImage;

  /// Description text for hero sections
  String? heroDescription;

  /// Main bottle image URL for product display
  String? bottleImage;

  /// First story image URL for product storytelling
  String? story1Image;

  /// Second story image URL for product storytelling
  String? story2Image;

  /// List of awards received by this product
  List<Award> awards;

  /// First story text for product storytelling
  String? story1;

  /// Second story text for product storytelling
  String? story2;

  /// List of botanical IDs used in this product
  List<int> botanicals;

  /// List of recipe slugs associated with this product
  List<String> recipeSlugs;

  /// Header alignment preference for product display ("left", "center", "right")
  String? headerAlignment;

  /// Shortcut key used in the pos system for this product
  String? shortcut;

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
    this.weight,
    this.enabled,
    double? matesRatesPrice,
    this.isArchived = false,
    this.recipe,
    this.isFeatured,
    this.heroImage,
    this.heroDescription,
    this.bottleImage,
    this.story1Image,
    this.story2Image,
    this.awards = const [],
    this.story1,
    this.story2,
    this.botanicals = const [],
    this.recipeSlugs = const [],
    this.headerAlignment,
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
