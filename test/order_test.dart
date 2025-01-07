import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('OrderModel', () {
    test('should serialize and deserialize with all fields', () {
      final customer = CustomerModel(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        phone: '0412345678',
        addressLine1: '123 Main St',
        addressLine2: 'Apt 4B',
        city: 'Melbourne',
        state: 'VIC',
        postcode: '3000',
        country: 'Australia',
      );

      final order = OrderModel(
        id: 'test-id',
        customer: customer,
        date: DateTime.parse('2024-01-07T12:00:00.000Z'),
        items: {
          'PRODUCT-001': 2,
          'PRODUCT-002': 1,
        },
        orderNumber: 'ORD-2024-001',
        paymentMethod: 'credit_card',
        totalQuote: 149.99,
        paymentReceipt: {'transactionId': 'TXN123', 'status': 'approved'},
        shippingMethod: 'FREEDELIVERY',
        shippingReceipt: {'trackingNumber': 'TRACK123', 'carrier': 'AusPost'},
      );

      final json = order.toJson();
      final decoded = OrderModel.fromJson(json);

      expect(decoded.id, equals(order.id));
      expect(decoded.customer.firstName, equals(order.customer.firstName));
      expect(decoded.customer.lastName, equals(order.customer.lastName));
      expect(
          decoded.date.toIso8601String(), equals(order.date.toIso8601String()));
      expect(decoded.items, equals(order.items));
      expect(decoded.orderNumber, equals(order.orderNumber));
      expect(decoded.paymentMethod, equals(order.paymentMethod));
      expect(decoded.paymentReceipt, equals(order.paymentReceipt));
      expect(decoded.shippingMethod, equals(order.shippingMethod));
      expect(decoded.shippingReceipt, equals(order.shippingReceipt));
      expect(decoded.totalQuote, equals(order.totalQuote));
    });

    test('should handle optional fields', () {
      final order = OrderModel(
        id: 'test-id',
        customer: CustomerModel(
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          phone: '0412345678',
          addressLine1: '123 Main St',
          addressLine2: '',
          city: 'Melbourne',
          state: 'VIC',
          postcode: '3000',
          country: 'Australia',
        ),
        date: DateTime.parse('2024-01-07T12:00:00.000Z'),
        items: {'PRODUCT-001': 1},
        orderNumber: 'ORD-2024-002',
        paymentMethod: 'cash',
        totalQuote: 35.00,
      );

      final json = order.toJson();
      final decoded = OrderModel.fromJson(json);

      expect(decoded.paymentReceipt, isNull);
      expect(decoded.shippingMethod, isNull);
      expect(decoded.shippingReceipt, isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => OrderModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
