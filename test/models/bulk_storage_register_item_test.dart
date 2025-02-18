import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('BulkStorageRegisterItemModel', () {
    group('toDatabase', () {
      test('should preserve ObjectId fields', () {
        final id = ObjectId();
        final fromVesselId = ObjectId();
        final toChargeId = ObjectId();

        final model = BulkStorageRegisterItemModel(
          id: id,
          fromVesselId: fromVesselId,
          toChargeId: toChargeId,
          lalsCalculation: AlcocalcLalsCalculation(
            weight: 10.0,
            abv: 0.15,
            temperature: 20.0,
          ),
        );

        final dbData = model.toDatabase();

        // Verify ObjectId fields are preserved
        expect(dbData['_id'], isA<ObjectId>());
        expect(dbData['_id'], equals(id));
        expect(dbData['fromVesselId'], isA<ObjectId>());
        expect(dbData['fromVesselId'], equals(fromVesselId));
        expect(dbData['toChargeId'], isA<ObjectId>());
        expect(dbData['toChargeId'], equals(toChargeId));
      });

      test('should handle null ObjectId fields', () {
        final model = BulkStorageRegisterItemModel(
          lalsCalculation: AlcocalcLalsCalculation(
            weight: 10.0,
            abv: 0.15,
            temperature: 20.0,
          ),
        );

        final dbData = model.toDatabase();

        // Verify required ObjectId is present
        expect(dbData['_id'], isA<ObjectId>());

        // Verify optional ObjectId fields are null or not present
        expect(dbData.containsKey('fromVesselId'), isFalse);
        expect(dbData.containsKey('toChargeId'), isFalse);
        expect(dbData.containsKey('fromChargeId'), isFalse);
        expect(dbData.containsKey('toVesselId'), isFalse);
        expect(dbData.containsKey('toPackagingId'), isFalse);
        expect(dbData.containsKey('fromPackagingId'), isFalse);
        expect(dbData.containsKey('productId'), isFalse);
      });

      test('should convert string ObjectIds to ObjectId instances', () {
        final id = ObjectId();
        final fromVesselId = ObjectId();
        final toChargeId = ObjectId();

        final model = BulkStorageRegisterItemModel(
          id: id,
          fromVesselId: fromVesselId,
          toChargeId: toChargeId,
          lalsCalculation: AlcocalcLalsCalculation(
            weight: 10.0,
            abv: 0.15,
            temperature: 20.0,
          ),
        );

        // First convert to JSON (which converts ObjectIds to strings)
        final json = model.toJson();

        // Create a new model from the JSON
        final modelFromJson = BulkStorageRegisterItemModel.fromJson(json);

        // Convert to database format
        final dbData = modelFromJson.toDatabase();

        // Verify ObjectIds are properly converted back
        expect(dbData['_id'], isA<ObjectId>());
        expect(dbData['_id'].toString(), equals(id.toString()));
        expect(dbData['fromVesselId'], isA<ObjectId>());
        expect(
            dbData['fromVesselId'].toString(), equals(fromVesselId.toString()));
        expect(dbData['toChargeId'], isA<ObjectId>());
        expect(dbData['toChargeId'].toString(), equals(toChargeId.toString()));
      });

      test('should preserve non-ObjectId fields', () {
        final lalsCalc = AlcocalcLalsCalculation(
          weight: 10.0,
          abv: 0.15,
          temperature: 20.0,
        );

        final model = BulkStorageRegisterItemModel(
          lalsCalculation: lalsCalc,
          isStocktake: true,
          feintsDestroyed: false,
          wastage: false,
          notes: 'Test notes',
        );

        final dbData = model.toDatabase();

        // Verify non-ObjectId fields are preserved
        expect(dbData['lalsCalculation'], equals(lalsCalc.toJson()));
        expect(dbData['isStocktake'], isTrue);
        expect(dbData['feintsDestroyed'], isFalse);
        expect(dbData['wastage'], isFalse);
        expect(dbData['notes'], equals('Test notes'));
      });

      test('should handle all ObjectId fields', () {
        final model = BulkStorageRegisterItemModel(
          fromChargeId: ObjectId(),
          fromVesselId: ObjectId(),
          toVesselId: ObjectId(),
          toChargeId: ObjectId(),
          toPackagingId: ObjectId(),
          fromPackagingId: ObjectId(),
          productId: ObjectId(),
          lalsCalculation: AlcocalcLalsCalculation(
            weight: 10.0,
            abv: 0.15,
            temperature: 20.0,
          ),
        );

        final dbData = model.toDatabase();

        // Verify all ObjectId fields are preserved
        expect(dbData['_id'], isA<ObjectId>());
        expect(dbData['fromChargeId'], isA<ObjectId>());
        expect(dbData['fromVesselId'], isA<ObjectId>());
        expect(dbData['toVesselId'], isA<ObjectId>());
        expect(dbData['toChargeId'], isA<ObjectId>());
        expect(dbData['toPackagingId'], isA<ObjectId>());
        expect(dbData['fromPackagingId'], isA<ObjectId>());
        expect(dbData['productId'], isA<ObjectId>());
      });
    });
  });
}
