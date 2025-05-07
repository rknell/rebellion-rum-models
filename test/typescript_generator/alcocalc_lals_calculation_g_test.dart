import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('AlcocalcLalsCalculation generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alcocalc_lals_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlcocalcLalsCalculation _\$AlcocalcLalsCalculationFromJson(
        Map<String, dynamic> json) =>
    AlcocalcLalsCalculation(
      weight: (json['weight'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
    );

Map<String, dynamic> _\$AlcocalcLalsCalculationToJson(
        AlcocalcLalsCalculation instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'abv': instance.abv,
      'temperature': instance.temperature,
    };
''';

    test(
        'should contain fromJson function with all required fields for AlcocalcLalsCalculation',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface AlcocalcLalsCalculation'),
        isTrue,
        reason:
            'Generated TypeScript should contain the AlcocalcLalsCalculation interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('weight: number'), isTrue);
      expect(result.contains('abv: number'), isTrue);
      expect(result.contains('temperature: number'), isTrue);
    });
  });
}
