import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('desktop data contract preserves typed IDs and UTC dates', () {
    final id = ObjectId();
    final now = DateTime.utc(2026, 10, 31);
    final request = DesktopDataRequest(
      operation: DesktopDataOperation.update,
      query: DesktopQuery(filter: {'_id': id}, limit: 50),
      document: {
        r'$set': {
          'updatedAt': now,
          'references': [id]
        }
      },
    );
    final decoded = DesktopDataRequest.fromJson(request.toJson());
    expect(decoded.query.filter['_id'], id);
    expect((decoded.document[r'$set'] as Map)['updatedAt'], now);
    expect(decoded.operation, DesktopDataOperation.update);
    expect(decoded.query.includeArchived, isFalse);
  });

  test('unknown operations and invalid bounds fail closed', () {
    expect(() => DesktopDataRequest.fromJson({'operation': 'runCommand'}),
        throwsFormatException);
    expect(() => DesktopQuery(limit: 1001), throwsArgumentError);
    expect(() => DesktopQuery(offset: -1), throwsArgumentError);
  });
}
