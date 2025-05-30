import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('StockJournalModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockJournalModel _\$StockJournalModelFromJson(Map<String, dynamic> json) =>
    StockJournalModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      qty: (json['qty'] as num).toDouble(),
    );

Map<String, dynamic> _\$StockJournalModelToJson(StockJournalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'type': instance.type,
      'from': instance.from,
      'to': instance.to,
      'qty': instance.qty,
    };
''';

    test(
        'should contain fromJson function with all required fields for StockJournalModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface StockJournalModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the StockJournalModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('_id: string'), isTrue);
      expect(result.contains('barcode: string'), isTrue);
      expect(result.contains('type: string'), isTrue);
      expect(result.contains('from: string'), isTrue);
      expect(result.contains('to: string'), isTrue);
      expect(result.contains('qty: number'), isTrue);
    });
  });
}
