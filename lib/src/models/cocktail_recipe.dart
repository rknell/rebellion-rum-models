import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'cocktail_recipe.g.dart';

/// Represents a cocktail recipe in the Rebellion Rum system.
///
/// This model stores complete cocktail recipe information including ingredients,
/// instructions, garnishes, and associated images. Each recipe has a unique
/// slug for URL-friendly identification and is designed to showcase drinks
/// that can be made with Rebellion Rum products.
///
/// Example:
/// ```dart
/// final recipe = CocktailRecipeModel(
///   name: 'Dark n Stormy',
///   slug: 'dark-n-stormy',
///   description: 'A refreshing Bermudian cocktail with spicy ginger beer and dark rum.',
///   ingredients: ['2 shots Cloak & Dagger dark rum', '4 shots ginger beer', '0.5 shot lime juice'],
///   instructions: ['Fill a glass with ice.', 'Add rum and lime juice.', 'Top with ginger beer.'],
///   glass: 'Highball',
///   garnish: 'Lime wedge, candied ginger',
/// );
/// ```
@JsonSerializable()
class CocktailRecipeModel extends DatabaseSerializable {
  /// The display name of the cocktail
  final String name;

  /// Detailed description of the cocktail
  final String description;

  /// Main image URL for the recipe
  final String? image;

  /// Thumbnail image URL for the recipe
  final String? imageThumbnail;

  /// URL-friendly slug for routing and identification
  final String slug;

  /// List of ingredients with measurements
  final List<String> ingredients;

  /// Step-by-step preparation instructions
  final List<String> instructions;

  /// Garnish description
  final String? garnish;

  /// Type of glass to serve in
  final String glass;

  /// AI-friendly description for image generation
  final String? llmDescription;

  /// Whether this recipe is featured on the homepage or in special sections
  final bool isFeatured;

  /// Whether this recipe is currently active/published
  final bool isActive;

  /// List of product IDs that this recipe showcases
  final List<String> featuredProductIds;

  /// Creation timestamp
  final DateTime? createdAt;

  /// Last updated timestamp
  final DateTime? updatedAt;

  CocktailRecipeModel({
    super.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.ingredients,
    required this.instructions,
    required this.glass,
    this.image,
    this.imageThumbnail,
    this.garnish,
    this.llmDescription,
    this.isFeatured = false,
    this.isActive = true,
    this.featuredProductIds = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory CocktailRecipeModel.fromJson(Map<String, dynamic> json) =>
      _$CocktailRecipeModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CocktailRecipeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
