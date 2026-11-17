import 'dart:convert';
import 'package:alcocalc/alcocalc.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

AlcocalcDilutionResultModel calculation() =>
    AlcocalcDilutionResultModel.fromAlcoCalc(Alcocalc.dilution(
        startingWeight: 60,
        startingABV: .65,
        startingTemperature: 20,
        targetABV: .4));

void main() {
  test('actual scale totals are optional and round trip with record identity',
      () {
    final base = PackagingDilutionModel(id: 'scale', calculation: calculation())
        .toJson();
    for (final weights in [
      null,
      <double?>[null],
      <double?>[0],
      <double?>[70.4]
    ]) {
      final copy = PackagingDilutionModel.fromJson(
          {...base, 'actualWeightsKg': weights});
      expect(copy.actualWeightsKg, weights);
      expect(PackagingDilutionModel.fromJson(copy.toJson()).actualWeightsKg,
          weights);
    }
    base.remove('actualWeightsKg');
    expect(PackagingDilutionModel.fromJson(base).actualWeightsKg, isNull);
    for (final invalid in [
      1,
      '70',
      <Object?>[],
      [null, null],
      ['70'],
      [double.nan],
      [double.infinity],
      [-1],
      [<String, Object?>{}]
    ]) {
      expect(
          () => PackagingDilutionModel.fromJson(
              {...base, 'actualWeightsKg': invalid}),
          throwsA(isA<FormatException>().having(
              (e) => e.message,
              'field and record',
              contains('Packaging dilution scale: invalid actualWeightsKg'))));
    }
    expect(
        () => PackagingDilutionModel(id: 'bad', actualWeightsKg: [1]).toJson(),
        throwsFormatException);
    expect(
        () => PackagingDilutionModel(
            id: 'bad',
            calculation: calculation(),
            actualWeightsKg: [double.nan]).toJson(),
        throwsFormatException);
  });
  test('three portions round trip as one run with one count and excise', () {
    final run = PackagingRunItemModel(
      productionDilution: calculation(), // stale legacy data must not be added
      dilutions: List.generate(
          3,
          (i) => PackagingDilutionModel(
              id: '$i', calculation: calculation(), abvReading: .4)),
      unitsPackaged: 400,
    );
    final copy =
        PackagingRunItemModel.fromJson(jsonDecode(jsonEncode(run.toJson())));
    expect(copy.effectiveDilutions.length, 3);
    expect(copy.totalDilutedVolume,
        closeTo(calculation().targetVolume * 3, .0001));
    expect(copy.allDilutionsChecked, isTrue);
    expect(copy.unitsPackaged, 400);
    expect(copy.toDatabase()['dilutions'], hasLength(3));
  });
  test('legacy missing/null list preserves its original calculation and ABV',
      () {
    final json =
        PackagingRunItemModel(productionDilution: calculation(), abvReading: .4)
            .toJson();
    for (final explicitNull in [false, true]) {
      if (explicitNull) json['dilutions'] = null;
      final copy = PackagingRunItemModel.fromJson(json);
      expect(copy.effectiveDilutions.single.id, 'legacy');
      expect(copy.allDilutionsChecked, isTrue);
    }
    json['dilutions'] = <dynamic>[];
    expect(PackagingRunItemModel.fromJson(json).effectiveDilutions, isEmpty);
  });
  test('unfinished and out-of-range portions prevent completion', () {
    for (final reading in [null, .2]) {
      final run = PackagingRunItemModel(dilutions: [
        PackagingDilutionModel(
            id: 'a', calculation: calculation(), abvReading: reading)
      ]);
      expect(run.allDilutionsChecked, isFalse);
    }
    expect(PackagingDilutionModel(id: 'a').isChecked, isFalse);
  });
  test('reject malformed lists and duplicate identity', () {
    for (final entries in [
      1,
      <String, dynamic>{},
      [null],
      [
        {'id': 'a'},
        {'id': 'a'}
      ]
    ]) {
      expect(() => PackagingRunItemModel.fromJson({'dilutions': entries}),
          throwsFormatException);
    }
  });
  test('reject missing/null/wrong/nonfinite calculation measurements', () {
    final valid =
        PackagingDilutionModel(id: 'portion', calculation: calculation())
            .toJson();
    for (final value in [null, '12', double.nan, double.infinity, -1]) {
      final json = Map<String, dynamic>.from(valid);
      json['calculation'] = {...valid['calculation'], 'startingWeight': value};
      expect(
          () => PackagingDilutionModel.fromJson(json), throwsFormatException);
    }
    final missing = Map<String, dynamic>.from(valid['calculation'])
      ..remove('lals');
    expect(
        () =>
            PackagingDilutionModel.fromJson({...valid, 'calculation': missing}),
        throwsFormatException);
    for (final value in ['40', double.nan, double.infinity, -1, 2]) {
      expect(
          () =>
              PackagingDilutionModel.fromJson({...valid, 'abvReading': value}),
          throwsFormatException);
    }
    expect(
        PackagingDilutionModel.fromJson({...valid, 'abvReading': 0}).abvReading,
        0);
    expect(() => PackagingDilutionModel.fromJson({'id': 'a', 'abvReading': .4}),
        throwsFormatException);
    expect(() => PackagingDilutionModel.fromJson({}), throwsFormatException);
  });
}
