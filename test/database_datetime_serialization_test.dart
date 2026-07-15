import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('toDatabase persists declared date fields as BSON Date values', () {
    final model = CustomerModel(
      id: ObjectId(),
      firstName: 'Test',
      lastName: 'Customer',
      email: 'test@example.com',
      phone: '0400000000',
      addressLine1: '1 Test Street',
      city: 'Brisbane',
      state: 'QLD',
      postcode: '4000',
      accountCreatedAt: DateTime.utc(2026, 7, 15, 1),
      passwordResetExpiresAt: DateTime.utc(2026, 7, 16, 1),
    );

    final database = model.toDatabase();
    final json = model.toJson(includePassword: true);

    expect(database['accountCreatedAt'], isA<DateTime>());
    expect(database['passwordResetExpiresAt'], isA<DateTime>());
    expect(json['accountCreatedAt'], isA<String>());
    expect(json['passwordResetExpiresAt'], isA<String>());
  });

  test('models accept BSON Date values when reading MongoDB documents', () {
    final model = EftposTerminalModel.fromJson({
      '_id': ObjectId(),
      'name': 'Front counter',
      'secret': 'test-secret',
      'createdAt': DateTime.utc(2026, 7, 15, 1),
      'lastUsed': DateTime.utc(2026, 7, 15, 2),
    });

    expect(model.createdAt, DateTime.utc(2026, 7, 15, 1));
    expect(model.lastUsed, DateTime.utc(2026, 7, 15, 2));
  });

  test('order operational metadata dates are BSON without touching vendor data',
      () {
    final model = OrderModel(
      id: ObjectId(),
      customerId: null,
      date: DateTime.utc(2026, 7, 15),
      items: const {},
      orderNumber: 'RUM11000',
      paymentMethod: 'card',
      metadata: {
        'stockAdjustedAt': '2026-07-15T01:00:00.000Z',
        'starshipit': {'order_date': '2026-07-15T02:00:00.000Z'},
      },
    );

    final database = model.toDatabase();
    final metadata = database['metadata'] as Map;

    expect(metadata['stockAdjustedAt'], isA<DateTime>());
    expect((metadata['starshipit'] as Map)['order_date'], isA<String>());
    expect(model.metadata['stockAdjustedAt'], isA<String>());
  });

  test('path conversion supports lists and leaves vendor dates untouched', () {
    final data = <String, dynamic>{
      'notes': <Map<String, dynamic>>[
        <String, dynamic>{'date': '2026-07-15T01:00:00.000Z'},
      ],
      'metadata': {
        'starshipit': {'order_date': '2026-07-15T01:00:00.000Z'},
      },
    };

    convertDatabaseDateFields(data, {'notes[].date'});

    expect((data['notes'] as List).first['date'], isA<DateTime>());
    expect(
      (data['metadata'] as Map)['starshipit']['order_date'],
      isA<String>(),
    );
  });
}
