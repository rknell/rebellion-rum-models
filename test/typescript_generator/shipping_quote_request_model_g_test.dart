import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('ShippingQuoteRequestModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_quote_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShippingQuoteRequestModel _\$ShippingQuoteRequestModelFromJson(
        Map<String, dynamic> json) =>
    ShippingQuoteRequestModel(
      address: StartShipItRateDestinationAddressModel.fromJson(
          json['address'] as Map<String, dynamic>),
      items: Map<String, int>.from(json['items'] as Map),
    );

Map<String, dynamic> _\$ShippingQuoteRequestModelToJson(
        ShippingQuoteRequestModel instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'items': instance.items,
    };
''';

    test(
        'should contain fromJson function with all required fields for ShippingQuoteRequestModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface ShippingQuoteRequestModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the ShippingQuoteRequestModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('address: StartShipItRateDestinationAddressModel'),
          isTrue);
      expect(result.contains('items: Record<string, number>'), isTrue);
    });
  });
}
