import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  Map<String, dynamic> batch() => ProductionBlendBatch(
          id: ObjectId().oid,
          vesselId: ObjectId().oid,
          name: 'Blend 1',
          createdAt: DateTime.utc(2026),
          settledMeasurement:
              AlcocalcLalsCalculation(weight: 80, abv: .65, temperature: 20),
          waterKg: 0)
      .toJson();
  test('legacy runs remain without workflow and round trip', () {
    final run = DistillationRecordModel(stillUsed: 'Still');
    expect(DistillationRecordModel.fromJson(run.toJson()).productionWorkflow,
        isNull);
    run.productionWorkflow =
        ProductionWorkflow(blends: [ProductionBlendBatch.fromJson(batch())]);
    final restored = DistillationRecordModel.fromJson(run.toJson());
    expect(restored.productionWorkflow!.blends.single.waterKg, 0);
    expect(
        restored.productionWorkflow!.blends.single.settledMeasurement!.weight,
        80);
    expect(restored.toDatabase()['productionWorkflow'],
        isA<Map<String, dynamic>>());
  });
  test('required batch numbers reject missing null wrong and nonfinite values',
      () {
    for (final key in ['targetKg', 'capacityLitres']) {
      for (final bad in [null, '80', double.nan, double.infinity, -1, 0]) {
        expect(() => ProductionBlendBatch.fromJson({...batch(), key: bad}),
            throwsFormatException);
      }
      final missing = batch()..remove(key);
      expect(
          () => ProductionBlendBatch.fromJson(missing), throwsFormatException);
    }
  });
  test('measurement validates nested persisted values', () {
    for (final bad in [null, '80', double.nan, double.infinity, -1]) {
      expect(
          () => productionMeasurementFromJson(
              {'weight': bad, 'abv': .65, 'temperature': 20}),
          throwsFormatException);
    }
    expect(
        () => productionMeasurementFromJson(
            {'weight': 80, 'abv': 65, 'temperature': 20}),
        throwsFormatException);
  });
  test('workflow rejects wrong version phase and rows', () {
    final valid = ProductionWorkflow().toJson();
    for (final key in ['version', 'phase', 'blends', 'operatorName']) {
      expect(() => ProductionWorkflow.fromJson({...valid, key: null}),
          throwsFormatException);
    }
  });
  test('movement dates and unknown provenance survive storage', () {
    final evidence = ProductionMovementEvidence(
        role: 'ingredient',
        blendBatchId: ObjectId().oid,
        occurredAt: DateTime.utc(2026, 1, 1),
        recordedAt: DateTime.utc(2026, 1, 3),
        operatorName: 'Ryan',
        reference: 'Receipt 42');
    final record = BulkStorageRegisterItemModel(
        legacyLals: 10, productionEvidence: evidence);
    final restored = BulkStorageRegisterItemModel.fromJson(record.toJson());
    expect(restored.productionEvidence!.ownAlcoholFraction, isNull);
    expect(restored.productionEvidence!.occurredAt.day, 1);
    expect(restored.productionEvidence!.recordedAt.day, 3);
    expect(
        () => ProductionMovementEvidence.fromJson(
            {...evidence.toJson(), 'ownAlcoholFraction': 1.01}),
        throwsFormatException);
  });
  test('movement evidence cannot hide an absent or invalid alcohol measurement',
      () {
    final evidence = ProductionMovementEvidence(
            role: 'charge',
            occurredAt: DateTime.utc(2026),
            recordedAt: DateTime.utc(2026),
            operatorName: 'Ryan',
            reference: 'Source')
        .toJson();
    for (final bad in [null, '10', double.nan, double.infinity, -1]) {
      expect(
          () => BulkStorageRegisterItemModel.fromJson({
                '_id': ObjectId().oid,
                'productionEvidence': evidence,
                'lals': bad
              }),
          throwsFormatException);
    }
  });
}
