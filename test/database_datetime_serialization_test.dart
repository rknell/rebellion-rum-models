import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('UTC JSON contract', () {
    test('serializes local DateTime values as ISO-8601 Zulu instants', () {
      final local = DateTime(2026, 7, 24, 11, 5, 32, 339, 465);

      final encoded = dateTimeToJson(local);

      expect(encoded, endsWith('Z'));
      expect(DateTime.parse(encoded), local.toUtc());
    });

    test('normalizes offset and legacy unzoned strings to UTC', () {
      expect(
        jsonToDateTime('2026-07-24T11:05:32.000+10:00'),
        DateTime.utc(2026, 7, 24, 1, 5, 32),
      );
      expect(
        jsonToDateTime('2026-07-24T01:05:32.000'),
        DateTime.utc(2026, 7, 24, 1, 5, 32),
      );
    });

    test('normalizes BSON Date values to UTC in memory and database', () {
      final local = DateTime(2026, 7, 24, 11, 5);
      final data = <String, dynamic>{'timestamp': local};

      convertDatabaseDateFields(data, const {'timestamp'});

      expect(jsonToDateTime(local), local.toUtc());
      expect(data['timestamp'], local.toUtc());
      expect((data['timestamp'] as DateTime).isUtc, isTrue);
    });
  });

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
    expect(json['accountCreatedAt'], endsWith('Z'));
    expect(json['passwordResetExpiresAt'], endsWith('Z'));
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
    final fromDatabase = PackagingMaterialMovementModel.fromJson({
      ...database,
      'timestamp': timestamp,
      'createdAt': timestamp,
    });

    expect(database['timestamp'], timestamp);
    expect(database['createdAt'], timestamp);
    expect(model.toJson()['timestamp'], endsWith('Z'));
    expect(model.toJson()['createdAt'], endsWith('Z'));
    expect(fromDatabase.timestamp, timestamp);
    expect(fromDatabase.createdAt, timestamp);
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

  test('operational models accept BSON Date values at legacy date fields', () {
    final timestamp = DateTime.utc(2026, 7, 17, 7);

    final sale = SaleModel.fromJson({
      '_id': ObjectId(),
      'timestamp': timestamp,
      'items': <Map<String, dynamic>>[],
      'payments': <Map<String, dynamic>>[],
      'coupons': <Map<String, dynamic>>[],
    });
    final rawMaterial = RawMaterialsRegisterModel.fromJson({
      '_id': ObjectId(),
      'materialType': 'molasses',
      'qtyIn': 100,
      'qtyOut': 0,
      'timestamp': timestamp,
    });
    final order = OrderModel.fromJson({
      '_id': ObjectId(),
      'customerId': null,
      'date': timestamp,
      'items': <String, int>{},
      'orderNumber': 'RUM-TEST',
      'paymentMethod': 'card',
    });
    final distillation = DistillationRecordModel.fromJson({
      '_id': ObjectId(),
      'startTime': timestamp,
      'distillationDate': timestamp,
    });

    expect(sale.timestamp, timestamp);
    expect(rawMaterial.timestamp, timestamp);
    expect(order.date, timestamp);
    expect(distillation.startTime, timestamp);
    expect(distillation.distillationDate, timestamp);
  });

  test('generated operational serializers do not require DateTime strings', () {
    const jsonTransportDateFiles = {
      'starshipit_create_order_request_model.g.dart',
      'starshipit_create_order_response_model.g.dart',
    };
    final unsafe = <String>[];
    final modelDirectory = Directory('lib/src/models');

    for (final entity in modelDirectory.listSync()) {
      if (entity is! File || !entity.path.endsWith('.g.dart')) continue;
      final fileName = entity.uri.pathSegments.last;
      if (jsonTransportDateFiles.contains(fileName)) continue;
      if (entity.readAsStringSync().contains(
            RegExp(r'DateTime\.parse\(json\[[^\]]+\] as String\)'),
          )) {
        unsafe.add(fileName);
      }
    }

    expect(
      unsafe,
      isEmpty,
      reason: 'MongoDB-facing serializers must accept BSON DateTime values. '
          'Use jsonToDateTime/jsonToNullableDateTime or explicitly normalize '
          'the database input.',
    );
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

  test('ObjectId-derived model timestamps are exposed as UTC instants', () {
    final bulk = BulkStorageRegisterItemModel(legacyLals: 1);
    final packaging = PackagingRunItemModel();

    expect(bulk.timestamp.isUtc, isTrue);
    expect(packaging.effectiveTimestamp.isUtc, isTrue);
  });
}
