import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/payment.dart';

void main() {
  group('PaymentModel', () {
    test('should serialize and deserialize with all fields', () {
      final payment = PaymentModel(
        type: 'credit_card',
        amount: 99.99,
        reference: 'REF123',
      );

      final json = payment.toJson();
      final decoded = PaymentModel.fromJson(json);

      expect(decoded.type, equals(payment.type));
      expect(decoded.amount, equals(payment.amount));
      expect(decoded.reference, equals(payment.reference));

      // Test the actual JSON structure
      expect(json['type'], equals('credit_card'));
      expect(json['amount'], equals(99.99));
      expect(json['reference'], equals('REF123'));
    });

    test('should handle optional fields', () {
      final payment = PaymentModel(
        type: 'cash',
        amount: 50.0,
      );

      final json = payment.toJson();
      final decoded = PaymentModel.fromJson(json);

      expect(decoded.type, equals(payment.type));
      expect(decoded.amount, equals(payment.amount));
      expect(decoded.reference, isNull);

      // Test the actual JSON structure
      expect(json['type'], equals('cash'));
      expect(json['amount'], equals(50.0));
      expect(json['reference'], isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => PaymentModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => PaymentModel.fromJson({
          'type': 123, // Wrong type (should be string)
          'amount': 50.0,
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => PaymentModel.fromJson({
          'type': 'cash',
          'amount': 'not-a-number', // Wrong type (should be number)
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => PaymentModel.fromJson({
          'type': 'cash',
          // Missing required amount field
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
