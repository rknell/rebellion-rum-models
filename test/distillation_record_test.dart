import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/distillation_record.dart';

void main() {
  group('DistillationRecordModel', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/distillationRecord.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should serialize and deserialize all sample records', () {
      for (final data in sampleData) {
        final model = DistillationRecordModel.fromJson(data);
        final serialized = model.toJson();

        // Compare individual fields
        expect(serialized['_id'], equals(data['_id']), reason: 'ID mismatch');
        expect(serialized['stillUsed'], equals(data['stillUsed']),
            reason: 'Still used mismatch');
        expect(serialized['feintsAdded'], equals(data['feintsAdded']),
            reason: 'Feints added mismatch');
        expect(serialized['lalsCharged'], equals(data['lalsCharged']),
            reason: 'LALs charged mismatch');
        expect(serialized['totalLALsCharged'], equals(data['totalLALsCharged']),
            reason: 'Total LALs charged mismatch');
        expect(serialized['totalLALsYield'], equals(data['totalLALsYield']),
            reason: 'Total LALs yield mismatch');

        // Compare notes
        final modelNotes = serialized['notes'] as List<dynamic>;
        final dataNotes = data['notes'] as List<dynamic>;
        expect(modelNotes.length, equals(dataNotes.length),
            reason: 'Notes length mismatch');

        for (var i = 0; i < modelNotes.length; i++) {
          expect(modelNotes[i]['content'], equals(dataNotes[i]['content']),
              reason: 'Note content mismatch');
          expect(modelNotes[i]['date'], equals(dataNotes[i]['date']),
              reason: 'Note date mismatch');
        }
      }
    });

    test('Invalid JSON handling', () {
      expect(
        () => DistillationRecordModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
