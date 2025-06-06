import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'utils/json_serialization_utils.dart';

void main() {
  group('BotanicalModel', () {
    test('should create a valid instance with required fields', () {
      final botanical = BotanicalModel(
        botanicalId: 8,
        name: 'Juniper',
        botanicalName: 'Juniperus communis',
        description: 'Essential botanical for gin production',
        image: '/assets/botanicals/juniper.png',
      );

      expect(botanical.botanicalId, equals(8));
      expect(botanical.name, equals('Juniper'));
      expect(botanical.botanicalName, equals('Juniperus communis'));
      expect(botanical.description,
          equals('Essential botanical for gin production'));
      expect(botanical.image, equals('/assets/botanicals/juniper.png'));
      expect(botanical.isActive, isTrue);
      expect(botanical.isFeatured, isFalse);
      expect(botanical.productIds, isEmpty);
      expect(botanical.id, isNotNull);
    });

    test('should handle optional fields correctly', () {
      final botanical = BotanicalModel(
        botanicalId: 6,
        name: 'Coriander',
        botanicalName: 'Coriandrum sativum',
        description: 'Citrusy, nutty flavor',
        image: '/assets/botanicals/coriander.png',
        isActive: false,
        isFeatured: true,
        productIds: ['product1', 'product2'],
      );

      expect(botanical.isActive, isFalse);
      expect(botanical.isFeatured, isTrue);
      expect(botanical.productIds, equals(['product1', 'product2']));
    });

    test('should serialize and deserialize correctly', () {
      final originalBotanical = BotanicalModel(
        botanicalId: 9,
        name: 'Lemon Myrtle',
        botanicalName: 'Backhousia citriodora',
        description: 'Australian native with intense citrus aroma',
        image: '/assets/botanicals/lemon_myrtle.png',
        isActive: true,
        isFeatured: true,
        productIds: ['gin123'],
      );

      // Serialize to JSON
      final json = originalBotanical.toJson();

      // Deserialize from JSON
      final deserializedBotanical = BotanicalModel.fromJson(json);

      // Compare all fields
      expect(deserializedBotanical.botanicalId,
          equals(originalBotanical.botanicalId));
      expect(deserializedBotanical.name, equals(originalBotanical.name));
      expect(deserializedBotanical.botanicalName,
          equals(originalBotanical.botanicalName));
      expect(deserializedBotanical.description,
          equals(originalBotanical.description));
      expect(deserializedBotanical.image, equals(originalBotanical.image));
      expect(
          deserializedBotanical.isActive, equals(originalBotanical.isActive));
      expect(deserializedBotanical.isFeatured,
          equals(originalBotanical.isFeatured));
      expect(deserializedBotanical.productIds,
          equals(originalBotanical.productIds));
      expect(deserializedBotanical.id.oid, equals(originalBotanical.id.oid));
    });

    test('should handle empty and null values correctly', () {
      final botanical = BotanicalModel(
        botanicalId: 1,
        name: 'Test Botanical',
        botanicalName: 'Testicus botanicus',
        description: 'A test botanical',
        image: '/test.png',
        productIds: [],
      );

      final json = botanical.toJson();
      final deserializedBotanical = BotanicalModel.fromJson(json);

      expect(deserializedBotanical.productIds, isEmpty);
      expect(deserializedBotanical.createdAt, isNull);
      expect(deserializedBotanical.updatedAt, isNull);
    });

    test('should include _id in objectIdFields', () {
      final botanical = BotanicalModel(
        botanicalId: 1,
        name: 'Test',
        botanicalName: 'Test',
        description: 'Test',
        image: '/test.png',
      );

      expect(botanical.objectIdFields, contains('_id'));
      expect(botanical.objectIdFields.length, equals(1));
    });

    test('should handle DateTime fields correctly', () {
      final now = DateTime.now();
      final botanical = BotanicalModel(
        botanicalId: 1,
        name: 'Test Botanical',
        botanicalName: 'Test',
        description: 'Test',
        image: '/test.png',
        createdAt: now,
        updatedAt: now,
      );

      final json = botanical.toJson();
      final deserializedBotanical = BotanicalModel.fromJson(json);

      expect(deserializedBotanical.createdAt, isNotNull);
      expect(deserializedBotanical.updatedAt, isNotNull);
      // Note: JSON serialization may lose microsecond precision
      expect(deserializedBotanical.createdAt!.millisecondsSinceEpoch,
          closeTo(now.millisecondsSinceEpoch, 1000));
    });

    test('should correctly map id field to botanicalId', () {
      // Test that the @JsonKey(name: 'id') annotation works correctly
      final json = {
        '_id': '507f1f77bcf86cd799439015',
        'id': 8,
        'name': 'Juniper',
        'botanicalName': 'Juniperus communis',
        'description': 'Test description',
        'image': '/test.png',
        'isActive': true,
        'isFeatured': false,
        'productIds': <String>[],
      };

      final botanical = BotanicalModel.fromJson(json);
      expect(botanical.botanicalId, equals(8));

      // Test serialization back to JSON
      final serializedJson = botanical.toJson();
      expect(serializedJson['id'], equals(8));
      expect(serializedJson.containsKey('botanicalId'), isFalse);
    });

    test('should handle boolean values correctly', () {
      final botanical = BotanicalModel(
        botanicalId: 1,
        name: 'Test',
        botanicalName: 'Test',
        description: 'Test',
        image: '/test.png',
        isActive: false,
        isFeatured: true,
      );

      final json = botanical.toJson();
      final deserializedBotanical = BotanicalModel.fromJson(json);

      expect(deserializedBotanical.isActive, isFalse);
      expect(deserializedBotanical.isFeatured, isTrue);
    });
  });

  // Use the standard JSON serialization tests
  createJsonSerializationTests<BotanicalModel>(
    resourcePath: 'resources/botanicals.json',
    fromJson: BotanicalModel.fromJson,
  );
}
