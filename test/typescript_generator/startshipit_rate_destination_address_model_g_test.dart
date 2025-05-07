import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('StartShipItRateDestinationAddressModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_rate_destination_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItRateDestinationAddressModel
    _\$StartShipItRateDestinationAddressModelFromJson(
            Map<String, dynamic> json) =>
        StartShipItRateDestinationAddressModel(
          street: json['street'] as String,
          suburb: json['suburb'] as String,
          state: json['state'] as String,
          postCode: json['post_code'] as String,
          countryCode: json['country_code'] as String? ?? 'AU',
        );

Map<String, dynamic> _\$StartShipItRateDestinationAddressModelToJson(
        StartShipItRateDestinationAddressModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'suburb': instance.suburb,
      'state': instance.state,
      'post_code': instance.postCode,
      'country_code': instance.countryCode,
    };
''';

    test('should contain fromJson function with all required fields', () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Verify that the generated TypeScript contains the interface definition
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains(
            'export interface StartShipItRateDestinationAddressModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the StartShipItRateDestinationAddressModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('street: string'), isTrue);
      expect(result.contains('suburb: string'), isTrue);
      expect(result.contains('state: string'), isTrue);
      expect(result.contains('post_code: string'), isTrue);
      expect(result.contains('country_code: string'), isTrue);
    });
  });
}
