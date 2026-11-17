import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('transfer preserves batch, dilution and inventory identity', () {
    final movement = BulkStorageRegisterItemModel(
        legacyLals: 40,
        toPackagingId: ObjectId(),
        packagingDilutionId: 'portion-a');
    final saved = BulkStorageRegisterItemModel.fromJson(movement.toJson());
    expect(saved.id, movement.id);
    expect(saved.toPackagingId, movement.toPackagingId);
    expect(saved.packagingDilutionId, 'portion-a');
    expect(saved.lals, 40);
  });
  test('old missing and null links remain unassigned', () {
    for (final json in [
      <String, dynamic>{'lals': 0},
      <String, dynamic>{'lals': 0, 'packagingDilutionId': null}
    ]) {
      expect(BulkStorageRegisterItemModel.fromJson(json).packagingDilutionId,
          isNull);
    }
  });
  test(
      'reject invalid links and links without a parent batch on read and write',
      () {
    for (final value in ['', ' ', 12, <dynamic>[], double.nan]) {
      expect(
          () => BulkStorageRegisterItemModel.fromJson({
                'lals': 1,
                'toPackagingId': ObjectId().oid,
                'packagingDilutionId': value,
              }),
          throwsFormatException);
    }
    expect(
        () => BulkStorageRegisterItemModel.fromJson({
              'lals': 1,
              'packagingDilutionId': 'a',
            }),
        throwsFormatException);
    expect(
        () => BulkStorageRegisterItemModel(
                legacyLals: 1, packagingDilutionId: 'a')
            .toJson(),
        throwsFormatException);
  });
  test('obsolete packaging method is ignored', () {
    final run = PackagingRunItemModel.fromJson({'dilutionMode': 'homogenised'});
    expect(run.toJson().containsKey('dilutionMode'), isFalse);
  });
}
