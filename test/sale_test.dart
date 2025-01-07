import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('SaleModel', () {
    late List<Map<String, dynamic>> sampleData;

    setUp(() {
      sampleData = [
        {
          '_id': 'test-id-1',
          'timestamp': '2024-01-07T12:00:00.000Z',
          'items': [
            {
              'description': 'White Stag Vodka',
              'price': 35.0,
              'itemId': '3538497880326',
              'qty': 2
            }
          ],
          'customerId': null,
          'coupons': {},
          'eftposSessionId': null,
          'payments': [
            {'type': 'credit_card', 'amount': 70.0, 'reference': 'TXN123'}
          ],
          'total': 70.0
        },
        {
          '_id': 'test-id-2',
          'timestamp': '2024-01-07T12:00:00.000Z',
          'items': [],
          'customerId': null,
          'coupons': [],
          'eftposSessionId': null,
          'payments': [],
          'discountTotal': null
        }
      ];
    });

    test('should deserialize all sample data', () {
      for (final data in sampleData) {
        expect(
          () => SaleModel.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('should serialize and deserialize with all fields', () {
      final timestamp = DateTime.parse('2024-01-07T12:00:00.000Z');
      final sale = SaleModel(
        id: 'test-id',
        timestamp: timestamp,
        items: [
          SaleItemModel(
              description: 'White Stag Vodka',
              price: 35.0,
              itemId: '3538497880326',
              qty: 2)
        ],
        customerId: null,
        coupons: {},
        eftposSessionId: null,
        payments: [
          PaymentModel(type: 'credit_card', amount: 70.0, reference: 'TXN123')
        ],
        total: 70.0,
        discountTotal: null,
      );

      final json = sale.toJson();
      final decoded = SaleModel.fromJson(json);

      expect(decoded.id, equals(sale.id));
      expect(decoded.timestamp?.toIso8601String(),
          equals(sale.timestamp?.toIso8601String()));
      expect(decoded.items.length, sale.items.length);
      expect(decoded.customerId, equals(sale.customerId));
      expect(decoded.coupons, equals(sale.coupons));
      expect(decoded.eftposSessionId, equals(sale.eftposSessionId));
      expect(decoded.payments.length, equals(sale.payments.length));
      expect(decoded.payments.first.type, equals(sale.payments.first.type));
      expect(decoded.payments.first.amount, equals(sale.payments.first.amount));
      expect(decoded.payments.first.reference,
          equals(sale.payments.first.reference));
      expect(decoded.total, equals(sale.total));
      expect(decoded.discountTotal, equals(sale.discountTotal));
    });

    test('should handle empty lists and null values', () {
      final sale = SaleModel(
        id: 'test-id',
        timestamp: DateTime.parse('2024-01-07T12:00:00.000Z'),
        items: [],
        customerId: null,
        coupons: [],
        eftposSessionId: null,
        payments: [],
        total: 0.0,
        discountTotal: null,
      );

      final json = sale.toJson();
      final decoded = SaleModel.fromJson(json);

      expect(decoded.items, isEmpty);
      expect(decoded.customerId, isNull);
      expect(decoded.coupons, isEmpty);
      expect(decoded.eftposSessionId, isNull);
      expect(decoded.payments, isEmpty);
      expect(decoded.total, equals(0.0));
      expect(decoded.discountTotal, isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => SaleModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
