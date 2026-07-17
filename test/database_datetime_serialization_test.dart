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

  test('packaging material movement dates use BSON Date values', () {
    final timestamp = DateTime.utc(2026, 7, 15, 3);
    final model = PackagingMaterialMovementModel(
      materialDefinitionId: ObjectId(),
      materialType: PackagingMaterialType.label,
      quantityDelta: 100,
      movementType: PackagingMaterialMovementType.purchase,
      sourceSystem: 'manager',
      sourceDocumentType: 'purchase',
      sourceDocumentId: 'delivery-1',
      idempotencyKey: 'purchase:delivery-1',
      timestamp: timestamp,
      createdAt: timestamp,
    );

    final database = model.toDatabase();

    expect(database['timestamp'], timestamp);
    expect(database['createdAt'], timestamp);
  });

  test('alcocalc nested models accept BSON Date values', () {
    final timestamp = DateTime.utc(2026, 7, 17, 6);
    final dilutionJson = <String, dynamic>{
      'date': timestamp,
      'startingWeight': 100,
      'correctedStartingABV': 0.6,
      'lals': 60,
      'additionalWaterLitres': 50,
      'targetWeightAfterWater': 150,
      'calculatedABV': 0.4,
      'acceptableABVLow': 0.395,
      'acceptableABVHigh': 0.405,
      'sugarResults': <Map<String, dynamic>>[],
      'targetVolume': 150,
      'expectedBottles': 214,
      'targetFinalWeight': 150,
    };

    final dilution = AlcocalcDilutionResultModel.fromJson(dilutionJson);
    final packagingRun = PackagingRunItemModel.fromJson({
      '_id': ObjectId(),
      'status': 'inProgress',
      'estimatedDilution': dilutionJson,
    });
    final input = AlcocalcDilutionInputModel.fromJson({
      'startingWeight': 100,
      'startingABV': 0.6,
      'startingTemperature': 20,
      'sugars': <Map<String, dynamic>>[],
      'targetABV': 0.4,
      'bottleSize': 0.7,
      'createdAt': timestamp,
    });
    final alcoholAddition = AlcoholAdditionResultModel.fromJson({
      'currentWeight': 100,
      'currentABV': 0.35,
      'targetABV': 0.4,
      'additionABV': 0.96,
      'temperature': 20,
      'correctedCurrentABV': 0.35,
      'correctedAdditionABV': 0.96,
      'currentDensity': 0.95,
      'additionDensity': 0.8,
      'targetDensity': 0.93,
      'currentVolume': 105,
      'currentAlcoholVolume': 36.75,
      'additionVolume': 10,
      'requiredAlcoholWeight': 8,
      'finalWeight': 108,
      'finalVolume': 115,
      'lals': 9.6,
      'createdAt': timestamp,
    });

    expect(dilution.date, timestamp);
    expect(packagingRun.estimatedDilution?.date, timestamp);
    expect(input.createdAt, timestamp);
    expect(alcoholAddition.createdAt, timestamp);
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

  test('order BSON metadata dates return to JSON as ISO strings', () {
    final model = OrderModel.fromJson({
      '_id': ObjectId(),
      'date': DateTime.utc(2026, 7, 15),
      'items': <String, int>{},
      'status': 'paid',
      'metadata': {
        'stockAdjustedAt': DateTime.utc(2026, 7, 15, 1),
        'starshipit': {'order_date': '2026-07-15T02:00:00.000Z'},
      },
    });

    expect(model.metadata['stockAdjustedAt'], isA<String>());
    expect(
      (model.metadata['starshipit'] as Map)['order_date'],
      isA<String>(),
    );
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
