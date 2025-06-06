import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('ProductModel', () {
    test('should deserialize products.json format with all new fields', () {
      final json = {
        "barcode": "3531954279220",
        "name": "Cloak & Dagger",
        "price": 59.99,
        "stock": 15,
        "volume": 700.0,
        "abv": 0.37,
        "shortDescription":
            "Unfiltered, unapologetic, and sneakily smooth—Australian cane spirit at its boldest.",
        "longDescription":
            "Cloak & Dagger (700mL) is Rebellion Rum Co's unapologetic tribute to the soul of sugarcane...",
        "isAvailableOnline": true,
        "category": "rum",
        "slug": "cloak-dagger",
        "isFeatured": true,
        "heroImage": "/assets/cloak_dagger_hero_beach.ac35d500.jpeg",
        "heroDescription":
            "Rich Australian-style cane spirit showcasing local molasses and raw sugar...",
        "bottleImage": "/assets/cloak_and_dagger_bottle_shot.7241c2a7.jpeg",
        "story1Image": "/assets/cloak_dagger_hero.2af30ffa.jpeg",
        "story2Image": "/assets/barrel-1.f21c56a0.jpeg",
        "awards": [
          {
            "id": 1,
            "level": "Bronze",
            "competition": "Australian International Rum Awards",
            "year": 2023
          }
        ],
        "story1": "Cloak & Dagger was born from a simple mission...",
        "story2": "Surrounded by sugarcane fields...",
        "botanicals": [11, 15],
        "recipeSlugs": [
          "dark-n-stormy",
          "rum-punch",
          "mai-tai",
          "hot-buttered-rum"
        ],
        "headerAlignment": "center"
      };

      final product = ProductModel.fromJson(json);

      // Test basic fields
      expect(product.barcode, equals('3531954279220'));
      expect(product.name, equals('Cloak & Dagger'));
      expect(product.price, equals(59.99));
      expect(product.stock, equals(15));
      expect(product.volume, equals(700.0));
      expect(product.abv, equals(0.37));
      expect(product.category, equals(ProductCategory.rum));
      expect(product.slug, equals('cloak-dagger'));

      // Test new fields
      expect(product.isFeatured, isTrue);
      expect(product.heroImage,
          equals('/assets/cloak_dagger_hero_beach.ac35d500.jpeg'));
      expect(product.heroDescription,
          contains('Rich Australian-style cane spirit'));
      expect(product.bottleImage,
          equals('/assets/cloak_and_dagger_bottle_shot.7241c2a7.jpeg'));
      expect(product.story1Image,
          equals('/assets/cloak_dagger_hero.2af30ffa.jpeg'));
      expect(product.story2Image, equals('/assets/barrel-1.f21c56a0.jpeg'));

      // Test awards
      expect(product.awards, hasLength(1));
      expect(product.awards.first.id, equals(1));
      expect(product.awards.first.level, equals('Bronze'));
      expect(product.awards.first.competition,
          equals('Australian International Rum Awards'));
      expect(product.awards.first.year, equals(2023));

      // Test story fields
      expect(product.story1,
          contains('Cloak & Dagger was born from a simple mission'));
      expect(product.story2, contains('Surrounded by sugarcane fields'));

      // Test arrays
      expect(product.botanicals, equals([11, 15]));
      expect(
          product.recipeSlugs,
          equals(
              ['dark-n-stormy', 'rum-punch', 'mai-tai', 'hot-buttered-rum']));

      // Test header alignment
      expect(product.headerAlignment, equals('center'));
    });

    test('should serialize to JSON with all new fields', () {
      final product = ProductModel(
        barcode: 'TEST123',
        price: 49.99,
        name: 'Test Product',
        stock: 10,
        category: ProductCategory.gin,
        isFeatured: true,
        heroImage: '/test-hero.jpg',
        awards: [
          Award(
            id: 1,
            level: 'Gold',
            competition: 'Test Awards',
            year: 2024,
          ),
        ],
        botanicals: [1, 2, 3],
        recipeSlugs: ['test-recipe'],
        headerAlignment: 'left',
      );

      final json = product.toJson();

      expect(json['barcode'], equals('TEST123'));
      expect(json['isFeatured'], isTrue);
      expect(json['heroImage'], equals('/test-hero.jpg'));
      expect(json['awards'], hasLength(1));
      expect(json['awards'][0]['level'], equals('Gold'));
      expect(json['botanicals'], equals([1, 2, 3]));
      expect(json['recipeSlugs'], equals(['test-recipe']));
      expect(json['headerAlignment'], equals('left'));
    });

    test('should handle missing optional new fields gracefully', () {
      final json = {
        "barcode": "TEST456",
        "name": "Basic Product",
        "price": 29.99,
        "category": "vodka"
      };

      final product = ProductModel.fromJson(json);

      expect(product.barcode, equals('TEST456'));
      expect(product.isFeatured, isNull);
      expect(product.heroImage, isNull);
      expect(product.awards, isEmpty);
      expect(product.botanicals, isEmpty);
      expect(product.recipeSlugs, isEmpty);
      expect(product.headerAlignment, isNull);
    });
  });

  group('Award', () {
    test('should serialize and deserialize correctly', () {
      final award = Award(
        id: 42,
        level: 'Platinum',
        competition: 'World Spirits Competition',
        year: 2024,
      );

      final json = award.toJson();
      final deserializedAward = Award.fromJson(json);

      expect(deserializedAward.id, equals(42));
      expect(deserializedAward.level, equals('Platinum'));
      expect(
          deserializedAward.competition, equals('World Spirits Competition'));
      expect(deserializedAward.year, equals(2024));
    });
  });
}
