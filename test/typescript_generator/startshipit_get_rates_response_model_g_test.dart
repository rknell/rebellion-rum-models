import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('StartShipItGetRatesResponseModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_get_rates_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItGetRatesResponseModel _\$StartShipItGetRatesResponseModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItGetRatesResponseModel(
      rates: (json['rates'] as List<dynamic>)
          .map((e) => StartShipItRateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _\$StartShipItGetRatesResponseModelToJson(
        StartShipItGetRatesResponseModel instance) =>
    <String, dynamic>{
      'rates': instance.rates.map((e) => e.toJson()).toList(),
      'success': instance.success,
    };
''';

    test(
        'should contain fromJson function with all required fields for StartShipItGetRatesResponseModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface StartShipItGetRatesResponseModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the StartShipItGetRatesResponseModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('rates: StartShipItRateModel[]'), isTrue);
      expect(result.contains('success: boolean'), isTrue);
    });
  });
}
