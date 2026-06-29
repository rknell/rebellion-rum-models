import 'package:test/test.dart';
import '../utils/test_logger.dart';

import '../../tools/generate_typescript_from_g_dart.dart';

void main() {
  group('StartShipItRateDestinationAddressModel generated code', () {
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
      quantityDelta: (json['quantityDelta'] as num).toDouble(),
      movementType: json['movementType'] as String,
      timestamp: jsonToDateTime(json['timestamp']),
      sourceSystem: json['sourceSystem'] as String,
      sourceDocumentType: json['sourceDocumentType'] as String,
      sourceDocumentId: json['sourceDocumentId'] as String,
      idempotencyKey: json['idempotencyKey'] as String,
      fromLocation: json['fromLocation'] as String?,
      toLocation: json['toLocation'] as String?,
      note: json['note'] as String?,
      actor: json['actor'] as String?,
      previousStock: (json['previousStock'] as num?)?.toInt(),
      resultingStock: (json['resultingStock'] as num?)?.toInt(),
      createdAt: jsonToDateTime(json['createdAt']),
    );

Map<String, dynamic> _\$StockJournalModelToJson(StockJournalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'quantityDelta': instance.quantityDelta,
      'movementType': instance.movementType,
      'timestamp': dateTimeToJson(instance.timestamp),
      'sourceSystem': instance.sourceSystem,
      'sourceDocumentType': instance.sourceDocumentType,
      'sourceDocumentId': instance.sourceDocumentId,
      'idempotencyKey': instance.idempotencyKey,
      if (instance.fromLocation case final value?) 'fromLocation': value,
      if (instance.toLocation case final value?) 'toLocation': value,
      if (instance.note case final value?) 'note': value,
      if (instance.actor case final value?) 'actor': value,
      if (instance.previousStock case final value?) 'previousStock': value,
      if (instance.resultingStock case final value?) 'resultingStock': value,
      'createdAt': dateTimeToJson(instance.createdAt),
    };

''';

    test('should contain fromJson function with all required fields', () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Log the generated TypeScript content for debugging
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      // Verify that the generated TypeScript contains the interface definition
      expect(
        result.contains('export interface StockJournalModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the StockJournalModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('barcode: string'), isTrue);
      expect(result.contains('quantityDelta: number'), isTrue);
      expect(result.contains('movementType: string'), isTrue);
      expect(result.contains('timestamp: any'), isTrue);
      expect(result.contains('sourceSystem: string'), isTrue);
      expect(result.contains('sourceDocumentType: string'), isTrue);
      expect(result.contains('sourceDocumentId: string'), isTrue);
      expect(result.contains('idempotencyKey: string'), isTrue);
      expect(result.contains('createdAt: any'), isTrue);
    });
  });
}
