import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('distillation record preserves distillery database fields', () {
    final date = DateTime.utc(2026, 6, 29);
    final model = DistillationRecordModel(
      stillUsed: 'still-1',
      startTime: date,
      distillationDate: date,
      chargeNumber: 42,
      alcoholType: DistillationAlcoholType.other,
      alcoholTypeOther: 'experimental',
    );

    final json = model.toJson();
    final parsed = DistillationRecordModel.fromJson(json);

    expect(parsed.distillationDate, equals(date));
    expect(parsed.chargeNumber, equals(42));
    expect(parsed.alcoholType, equals(DistillationAlcoholType.other));
    expect(parsed.alcoholTypeOther, equals('experimental'));
  });

  test('fermentation record preserves final strength metadata', () {
    final timestamp = DateTime.utc(2026, 6, 29, 1, 2, 3);
    final deletedAt = DateTime.utc(2026, 6, 29, 2, 3, 4);
    final model = FermentationRecordModel(
      batchNumber: 12,
      type: FermentationType.molasses,
      washVolume: 1000,
      vesselBarcode: 'FV-1',
      sgStart: 1.08,
      sgEnd: 1.01,
      finalStrengthPercent: 9.5,
      finalStrengthMethod: 'manual',
      finalStrengthTimestamp: timestamp,
      isDeleted: true,
      deletedAt: deletedAt,
    );

    final parsed = FermentationRecordModel.fromJson(model.toJson());

    expect(parsed.finalStrengthPercent, equals(9.5));
    expect(parsed.finalStrengthMethod, equals('manual'));
    expect(parsed.finalStrengthTimestamp, equals(timestamp));
    expect(parsed.isDeleted, isTrue);
    expect(parsed.deletedAt, equals(deletedAt));
  });

  test('raw material definition is a shared database model', () {
    final model = RawMaterialDefinitionModel(
      materialKey: 'molasses',
      displayName: 'Molasses',
      unit: 'l',
      sortOrder: 10,
    );

    final parsed = RawMaterialDefinitionModel.fromJson(model.toJson());

    expect(parsed.materialKey, equals('molasses'));
    expect(parsed.displayName, equals('Molasses'));
    expect(parsed.unit, equals('l'));
    expect(parsed.sortOrder, equals(10));
    expect(parsed.isActive, isTrue);
  });

  test('volume transfer preserves wash strength metadata', () {
    final timestamp = DateTime.utc(2026, 6, 29, 4, 5, 6);
    final model = VolumeTransferredRecordModel(
      chargeId: ObjectId(),
      washId: ObjectId(),
      volume: 250,
      lals: 20,
      abvPercent: 8,
      strengthMethod: WashStrengthMethod.estimatedFromSg,
      timestamp: timestamp,
    );

    final parsed = VolumeTransferredRecordModel.fromJson(model.toJson());

    expect(parsed.abvPercent, equals(8));
    expect(parsed.strengthMethod, equals(WashStrengthMethod.estimatedFromSg));
    expect(parsed.timestamp, equals(timestamp));
  });

  test('raw materials register supports fractional quantities', () {
    final model = RawMaterialsRegisterModel(
      materialType: 'molasses',
      qtyIn: 12.34,
      qtyOut: 0.25,
    );

    final parsed = RawMaterialsRegisterModel.fromJson(model.toJson());

    expect(parsed.qtyIn, equals(12.34));
    expect(parsed.qtyOut, equals(0.25));
  });
}
