import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/sale.dart';
import 'package:rebellion_rum_models/src/models/sale_item.dart';
import 'package:rebellion_rum_models/src/models/payment.dart';

void main() {
  group('Sale', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/sales.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should successfully deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => Sale.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('should serialize and deserialize with all fields', () {
      final timestamp = DateTime.now();
      final sale = Sale(
        id: 'test-id',
        timestamp: timestamp,
        items: [
          SaleItem(
            description: 'Test Item',
            price: 29.99,
            itemId: 'ITEM123',
            qty: 2,
          ),
        ],
        customerId: 'CUST123',
        coupons: {'code': 'TEST10', 'discount': 10},
        total: 59.98,
        discountTotal: 49.98,
        eftposSessionId: 'SESSION123',
        payments: [
          Payment(
            type: 'credit_card',
            amount: 49.98,
            reference: 'REF123',
          ),
        ],
      );

      final json = sale.toJson();
      final decoded = Sale.fromJson(json);

      expect(decoded.id, equals(sale.id));
      expect(decoded.timestamp?.toIso8601String(),
          equals(sale.timestamp?.toIso8601String()));
      expect(decoded.items.length, equals(sale.items.length));
      expect(decoded.items[0].description, equals(sale.items[0].description));
      expect(decoded.items[0].price, equals(sale.items[0].price));
      expect(decoded.items[0].itemId, equals(sale.items[0].itemId));
      expect(decoded.items[0].qty, equals(sale.items[0].qty));
      expect(decoded.customerId, equals(sale.customerId));
      expect(decoded.coupons, equals(sale.coupons));
      expect(decoded.total, equals(sale.total));
      expect(decoded.discountTotal, equals(sale.discountTotal));
      expect(decoded.eftposSessionId, equals(sale.eftposSessionId));
      expect(decoded.payments.length, equals(sale.payments.length));
      expect(decoded.payments[0].type, equals(sale.payments[0].type));
      expect(decoded.payments[0].amount, equals(sale.payments[0].amount));
      expect(decoded.payments[0].reference, equals(sale.payments[0].reference));
    });

    test('should handle minimal fields and defaults', () {
      final sale = Sale(
        id: 'test-id',
        items: [], // Should use default empty list
        coupons: {}, // Empty map
        payments: [], // Should use default empty list
      );

      final json = sale.toJson();
      final decoded = Sale.fromJson(json);

      expect(decoded.id, equals(sale.id));
      expect(decoded.timestamp, isNull);
      expect(decoded.items, isEmpty);
      expect(decoded.customerId, isNull);
      expect(decoded.coupons, equals({}));
      expect(decoded.total, isNull);
      expect(decoded.discountTotal, isNull);
      expect(decoded.eftposSessionId, isNull);
      expect(decoded.payments, isEmpty);
    });

    test('should handle coupons as array', () {
      final sale = Sale(
        id: 'test-id',
        items: [],
        coupons: [], // Test coupons as array
        payments: [],
      );

      final json = sale.toJson();
      final decoded = Sale.fromJson(json);

      expect(decoded.coupons, equals([]));
    });

    test('Invalid JSON handling', () {
      expect(
        () => Sale.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Sale.fromJson({
          '_id': 'test',
          'timestamp': 'not-a-date',
          'items': [],
          'coupons': {},
          'payments': [],
        }),
        throwsA(isA<FormatException>()),
      );

      expect(
        () => Sale.fromJson({
          '_id': 'test',
          'items': [
            {'invalid': 'item'}
          ],
          'coupons': {},
          'payments': [],
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Sale.fromJson({
          '_id': 'test',
          'items': [],
          'coupons': {},
          'payments': [
            {'invalid': 'payment'}
          ],
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
