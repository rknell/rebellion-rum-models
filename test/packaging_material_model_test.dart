import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('PackagingMaterialDefinitionModel', () {
    test('serializes defaults and calculated label weight', () {
      final model = PackagingMaterialDefinitionModel(
        type: PackagingMaterialType.label,
        displayName: 'American Oak Label',
        productBarcode: 'AO-700',
        labelTareWeightGrams: 85,
        tenLabelSampleWeightGrams: 12.5,
      );

      expect(model.warningThreshold, 600);
      expect(model.unit, 'each');
      expect(model.singleLabelWeightGrams, 1.25);
      expect(model.hasLabelCalculationData, isTrue);

      final roundTrip =
          PackagingMaterialDefinitionModel.fromJson(model.toJson());
      expect(roundTrip.type, PackagingMaterialType.label);
      expect(roundTrip.productBarcode, 'AO-700');
      expect(roundTrip.singleLabelWeightGrams, 1.25);
    });

    test('handles non-label definitions without label data', () {
      final model = PackagingMaterialDefinitionModel(
        type: PackagingMaterialType.bottle,
        displayName: 'Bottle',
      );

      expect(model.hasLabelCalculationData, isFalse);
      expect(model.singleLabelWeightGrams, isNull);
    });
  });

  group('PackagingMaterialMovementModel', () {
    test('serializes movement metadata and object ids', () {
      final definitionId = ObjectId();
      final timestamp = DateTime.utc(2026, 7, 7, 1, 2, 3);
      final model = PackagingMaterialMovementModel(
        materialDefinitionId: definitionId,
        materialType: PackagingMaterialType.bottle,
        quantityDelta: 24,
        movementType: PackagingMaterialMovementType.bottleReturn,
        sourceSystem: 'pointofsale',
        sourceDocumentType: 'sale',
        sourceDocumentId: 'SALE-1',
        idempotencyKey: 'pos-sale:SALE-1:bottle-return',
        timestamp: timestamp,
      );

      final json = model.toJson();
      expect(json['materialDefinitionId'], definitionId.oid);
      expect(json['movementType'], 'bottleReturn');

      final roundTrip = PackagingMaterialMovementModel.fromJson(json);
      expect(roundTrip.materialDefinitionId, definitionId);
      expect(roundTrip.materialType, PackagingMaterialType.bottle);
      expect(roundTrip.quantityDelta, 24);
      expect(roundTrip.timestamp, timestamp);
      expect(roundTrip.createdAt, timestamp);
    });
  });
}
