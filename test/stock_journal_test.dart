import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/stock_journal.dart';

void main() {
  group('StockJournalModel', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/stockJournal.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should serialize and deserialize all sample records', () {
      for (final data in sampleData) {
        final model = StockJournalModel.fromJson(data);
        final serialized = model.toJson();
        expect(
          jsonEncode(serialized),
          equals(jsonEncode(data)),
          reason: 'Failed on record with id: ${data['_id']}',
        );
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => StockJournalModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
