import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'utils/json_serialization_utils.dart';

void main() {
  group('CocktailRecipeModel', () {
    test('should create a valid instance with required fields', () {
      final recipe = CocktailRecipeModel(
        name: 'Test Recipe',
        description: 'A test cocktail recipe',
        slug: 'test-recipe',
        ingredients: ['50ml gin', '150ml tonic'],
        instructions: ['Mix ingredients', 'Serve over ice'],
        glass: 'Highball',
      );

      expect(recipe.name, equals('Test Recipe'));
      expect(recipe.description, equals('A test cocktail recipe'));
      expect(recipe.slug, equals('test-recipe'));
      expect(recipe.ingredients, equals(['50ml gin', '150ml tonic']));
      expect(
          recipe.instructions, equals(['Mix ingredients', 'Serve over ice']));
      expect(recipe.glass, equals('Highball'));
      expect(recipe.isFeatured, isFalse);
      expect(recipe.isActive, isTrue);
      expect(recipe.featuredProductIds, isEmpty);
      expect(recipe.id, isNotNull);
    });

    test('should handle optional fields correctly', () {
      final recipe = CocktailRecipeModel(
        name: 'Test Recipe',
        description: 'A test cocktail recipe',
        slug: 'test-recipe',
        ingredients: ['50ml gin'],
        instructions: ['Serve neat'],
        glass: 'Shot',
        image: 'test.png',
        imageThumbnail: 'test_thumb.png',
        garnish: 'Lemon twist',
        llmDescription: 'A test description',
        isFeatured: true,
        isActive: false,
        featuredProductIds: ['product1', 'product2'],
      );

      expect(recipe.image, equals('test.png'));
      expect(recipe.imageThumbnail, equals('test_thumb.png'));
      expect(recipe.garnish, equals('Lemon twist'));
      expect(recipe.llmDescription, equals('A test description'));
      expect(recipe.isFeatured, isTrue);
      expect(recipe.isActive, isFalse);
      expect(recipe.featuredProductIds, equals(['product1', 'product2']));
    });

    test('should serialize and deserialize correctly', () {
      final originalRecipe = CocktailRecipeModel(
        name: 'Dark n Stormy',
        description: 'A refreshing rum cocktail',
        slug: 'dark-n-stormy',
        ingredients: ['2 shots rum', '4 shots ginger beer'],
        instructions: ['Add ingredients to glass', 'Stir gently'],
        glass: 'Highball',
        garnish: 'Lime wedge',
        isFeatured: true,
        featuredProductIds: ['prod123'],
      );

      // Serialize to JSON
      final json = originalRecipe.toJson();

      // Deserialize from JSON
      final deserializedRecipe = CocktailRecipeModel.fromJson(json);

      // Compare all fields
      expect(deserializedRecipe.name, equals(originalRecipe.name));
      expect(
          deserializedRecipe.description, equals(originalRecipe.description));
      expect(deserializedRecipe.slug, equals(originalRecipe.slug));
      expect(
          deserializedRecipe.ingredients, equals(originalRecipe.ingredients));
      expect(
          deserializedRecipe.instructions, equals(originalRecipe.instructions));
      expect(deserializedRecipe.glass, equals(originalRecipe.glass));
      expect(deserializedRecipe.garnish, equals(originalRecipe.garnish));
      expect(deserializedRecipe.isFeatured, equals(originalRecipe.isFeatured));
      expect(deserializedRecipe.isActive, equals(originalRecipe.isActive));
      expect(deserializedRecipe.featuredProductIds,
          equals(originalRecipe.featuredProductIds));
      expect(deserializedRecipe.id.oid, equals(originalRecipe.id.oid));
    });

    test('should handle null and empty values correctly', () {
      final recipe = CocktailRecipeModel(
        name: 'Simple Recipe',
        description: 'Basic test',
        slug: 'simple-recipe',
        ingredients: [],
        instructions: [],
        glass: 'Any',
        image: null,
        imageThumbnail: null,
        garnish: null,
        llmDescription: null,
        featuredProductIds: [],
      );

      final json = recipe.toJson();
      final deserializedRecipe = CocktailRecipeModel.fromJson(json);

      expect(deserializedRecipe.image, isNull);
      expect(deserializedRecipe.imageThumbnail, isNull);
      expect(deserializedRecipe.garnish, isNull);
      expect(deserializedRecipe.llmDescription, isNull);
      expect(deserializedRecipe.ingredients, isEmpty);
      expect(deserializedRecipe.instructions, isEmpty);
      expect(deserializedRecipe.featuredProductIds, isEmpty);
    });

    test('should include _id in objectIdFields', () {
      final recipe = CocktailRecipeModel(
        name: 'Test',
        description: 'Test',
        slug: 'test',
        ingredients: [],
        instructions: [],
        glass: 'Test',
      );

      expect(recipe.objectIdFields, contains('_id'));
      expect(recipe.objectIdFields.length, equals(1));
    });

    test('should handle DateTime fields correctly', () {
      final now = DateTime.now();
      final recipe = CocktailRecipeModel(
        name: 'Test Recipe',
        description: 'Test',
        slug: 'test',
        ingredients: [],
        instructions: [],
        glass: 'Test',
        createdAt: now,
        updatedAt: now,
      );

      final json = recipe.toJson();
      final deserializedRecipe = CocktailRecipeModel.fromJson(json);

      expect(deserializedRecipe.createdAt, isNotNull);
      expect(deserializedRecipe.updatedAt, isNotNull);
      // Note: JSON serialization may lose microsecond precision
      expect(deserializedRecipe.createdAt!.millisecondsSinceEpoch,
          closeTo(now.millisecondsSinceEpoch, 1000));
    });
  });

  // Use the standard JSON serialization tests
  createJsonSerializationTests<CocktailRecipeModel>(
    resourcePath: 'resources/cocktailRecipes.json',
    fromJson: CocktailRecipeModel.fromJson,
  );
}
