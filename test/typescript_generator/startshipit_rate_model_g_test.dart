import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('StartShipItRateModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRateModel _\$StartShipItRateModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItRateModel(
      serviceName: json['service_name'] as String,
      serviceCode: json['service_code'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
    );

Map<String, dynamic> _\$StartShipItRateModelToJson(
        StartShipItRateModel instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'service_code': instance.serviceCode,
      'total_price': instance.totalPrice,
    };
''';

    test(
        'should contain fromJson function with all required fields for StartShipItRateModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface StartShipItRateModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the StartShipItRateModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('service_name: string'), isTrue);
      expect(result.contains('service_code: string'), isTrue);
      expect(result.contains('total_price: number'), isTrue);
    });
  });
}
