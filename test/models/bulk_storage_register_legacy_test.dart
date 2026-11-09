import 'package:test/test.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  final valid = {'weight': 10, 'abv': 0.4, 'temperature': 20};
  final invalid = <Object?>[
    {},
    for (final field in valid.keys)
      for (final value in [null, '10', double.nan, double.infinity])
        {...valid, field: value},
    for (final field in valid.keys) {...valid}..remove(field),
    'invalid',
  ];
  for (var index = 0; index < invalid.length; index++) {
    test('invalid calculation $index uses recorded legacy LALs', () {
      final json = <String, dynamic>{
        'lalsCalculation': invalid[index],
        'lals': 12,
      };
      final model = BulkStorageRegisterItemModel.fromJson(json);
      expect(model.lals, 12);
      expect(model.lalsCalculation, isNull);
      expect(json['lalsCalculation'], invalid[index]);
      expect(BulkStorageRegisterItemModel.fromJson(model.toJson()).lals, 12);
    });
    test('invalid calculation $index without legacy identifies record', () {
      final id = ObjectId();
      expect(
        () => BulkStorageRegisterItemModel.fromJson({
          '_id': id,
          'lalsCalculation': invalid[index],
        }),
        throwsA(isA<FormatException>().having(
            (error) => error.message, 'message', contains(id.toString()))),
      );
    });
  }
  test('valid calculation takes precedence over legacy and round trips', () {
    final model = BulkStorageRegisterItemModel.fromJson({
      'lalsCalculation': valid,
      'lals': 999,
    });
    expect(model.lals, AlcocalcLalsCalculation.fromJson(valid).lals);
    expect(
        BulkStorageRegisterItemModel.fromJson(model.toJson()).lals, model.lals);
  });
  test('explicit null and absent calculation support legacy zero', () {
    for (final json in <Map<String, dynamic>>[
      {'lals': 0},
      {'lals': 0, 'lalsCalculation': null},
      {'lals': 0, 'lalsCalculation': <String, dynamic>{}},
    ]) {
      expect(BulkStorageRegisterItemModel.fromJson(json).lals, 0);
    }
  });
  test('unusable legacy values are rejected without a calculation', () {
    for (final legacy in [null, '12', double.nan, double.infinity]) {
      expect(() => BulkStorageRegisterItemModel.fromJson({'lals': legacy}),
          throwsFormatException);
    }
  });
  test('standalone calculation reports missing field', () {
    expect(
        () => AlcocalcLalsCalculation.fromJson({}),
        throwsA(isA<FormatException>()
            .having((error) => error.message, 'message', contains('weight'))));
  });
}
