import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('AlcocalcDilutionResultModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alcocalc_dilution_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlcocalcDilutionResultModel _\$AlcocalcDilutionResultModelFromJson(
        Map<String, dynamic> json) =>
    AlcocalcDilutionResultModel(
      date: DateTime.parse(json['date'] as String),
      startingWeight: (json['startingWeight'] as num).toDouble(),
      correctedStartingABV: (json['correctedStartingABV'] as num).toDouble(),
      lals: (json['lals'] as num).toDouble(),
      additionalWaterLitres: (json['additionalWaterLitres'] as num).toDouble(),
      targetWeightAfterWater:
          (json['targetWeightAfterWater'] as num).toDouble(),
      calculatedABV: (json['calculatedABV'] as num).toDouble(),
      acceptableABVLow: (json['acceptableABVLow'] as num).toDouble(),
      acceptableABVHigh: (json['acceptableABVHigh'] as num).toDouble(),
      sugarResults: (json['sugarResults'] as List<dynamic>)
          .map((e) => SugarResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetVolume: (json['targetVolume'] as num).toDouble(),
      expectedBottles: (json['expectedBottles'] as num).toDouble(),
      targetFinalWeight: (json['targetFinalWeight'] as num).toDouble(),
    );

Map<String, dynamic> _\$AlcocalcDilutionResultModelToJson(
        AlcocalcDilutionResultModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'startingWeight': instance.startingWeight,
      'correctedStartingABV': instance.correctedStartingABV,
      'lals': instance.lals,
      'additionalWaterLitres': instance.additionalWaterLitres,
      'targetWeightAfterWater': instance.targetWeightAfterWater,
      'calculatedABV': instance.calculatedABV,
      'acceptableABVLow': instance.acceptableABVLow,
      'acceptableABVHigh': instance.acceptableABVHigh,
      'sugarResults': instance.sugarResults.map((e) => e.toJson()).toList(),
      'targetVolume': instance.targetVolume,
      'expectedBottles': instance.expectedBottles,
      'targetFinalWeight': instance.targetFinalWeight,
    };
''';

    test('should contain fromJson function with all required fields', () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Verify that the generated TypeScript contains the interface definition
      // Print the generated TypeScript content for debugging
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface AlcocalcDilutionResultModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the AlcocalcDilutionResultModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('date: string'), isTrue);
      expect(result.contains('startingWeight: number'), isTrue);
      expect(result.contains('correctedStartingABV: number'), isTrue);
      expect(result.contains('lals: number'), isTrue);
      expect(result.contains('additionalWaterLitres: number'), isTrue);
      expect(result.contains('targetWeightAfterWater: number'), isTrue);
      expect(result.contains('calculatedABV: number'), isTrue);
      expect(result.contains('acceptableABVLow: number'), isTrue);
      expect(result.contains('acceptableABVHigh: number'), isTrue);
      expect(result.contains('sugarResults: SugarResultModel[]'), isTrue);
      expect(result.contains('targetVolume: number'), isTrue);
      expect(result.contains('expectedBottles: number'), isTrue);
      expect(result.contains('targetFinalWeight: number'), isTrue);
    });
  });
}
