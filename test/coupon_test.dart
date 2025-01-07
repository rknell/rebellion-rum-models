import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/coupon.dart';

void main() {
  group('Coupon', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/coupons.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => Coupon.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('should serialize and deserialize correctly', () {
      for (final data in sampleData) {
        final coupon = Coupon.fromJson(data);
        final serialized = coupon.toJson();
        final deserialized = Coupon.fromJson(serialized);

        expect(deserialized.id, equals(coupon.id));
        expect(deserialized.code, equals(coupon.code));
        expect(deserialized.description, equals(coupon.description));
        expect(deserialized.amount, equals(coupon.amount));
        expect(deserialized.email, equals(coupon.email));
        expect(deserialized.phone, equals(coupon.phone));
        expect(deserialized.redeemed, equals(coupon.redeemed));
        expect(deserialized.remainingValue, equals(coupon.remainingValue));
        expect(deserialized.originalAmount, equals(coupon.originalAmount));
      }
    });

    test('should handle optional fields correctly', () {
      final couponWithAllFields = Coupon(
        id: 'test-id',
        code: 'TEST123',
        description: 'Test coupon',
        amount: 100.0,
        email: 'test@example.com',
        phone: '1234567890',
        redeemed: true,
        remainingValue: 50.0,
        originalAmount: 100.0,
      );

      final couponWithMinimalFields = Coupon(
        id: 'test-id',
        code: 'TEST123',
        description: 'Test coupon',
        amount: 100.0,
        email: 'test@example.com',
      );

      // Test all fields present
      final allFieldsJson = couponWithAllFields.toJson();
      expect(allFieldsJson['phone'], equals('1234567890'));
      expect(allFieldsJson['redeemed'], isTrue);
      expect(allFieldsJson['remainingValue'], equals(50.0));
      expect(allFieldsJson['originalAmount'], equals(100.0));

      // Test optional fields absent
      final minimalFieldsJson = couponWithMinimalFields.toJson();
      expect(minimalFieldsJson.containsKey('phone'), isFalse);
      expect(minimalFieldsJson.containsKey('redeemed'), isFalse);
      expect(minimalFieldsJson.containsKey('remainingValue'), isFalse);
      expect(minimalFieldsJson.containsKey('originalAmount'), isFalse);
    });

    test('should handle mixed optional fields', () {
      // Test each optional field independently
      final coupons = [
        Coupon(
          id: 'test-id',
          code: 'TEST123',
          description: 'Test coupon',
          amount: 100.0,
          email: 'test@example.com',
          phone: '1234567890', // Only phone set
        ),
        Coupon(
          id: 'test-id',
          code: 'TEST123',
          description: 'Test coupon',
          amount: 100.0,
          email: 'test@example.com',
          redeemed: true, // Only redeemed set
        ),
        Coupon(
          id: 'test-id',
          code: 'TEST123',
          description: 'Test coupon',
          amount: 100.0,
          email: 'test@example.com',
          remainingValue: 50.0, // Only remainingValue set
        ),
        Coupon(
          id: 'test-id',
          code: 'TEST123',
          description: 'Test coupon',
          amount: 100.0,
          email: 'test@example.com',
          originalAmount: 100.0, // Only originalAmount set
        ),
      ];

      for (final coupon in coupons) {
        final json = coupon.toJson();
        final decoded = Coupon.fromJson(json);
        expect(decoded.id, equals(coupon.id));
        expect(decoded.code, equals(coupon.code));
        expect(decoded.description, equals(coupon.description));
        expect(decoded.amount, equals(coupon.amount));
        expect(decoded.email, equals(coupon.email));
        expect(decoded.phone, equals(coupon.phone));
        expect(decoded.redeemed, equals(coupon.redeemed));
        expect(decoded.remainingValue, equals(coupon.remainingValue));
        expect(decoded.originalAmount, equals(coupon.originalAmount));
      }
    });

    test('should handle explicit null values', () {
      final coupon = Coupon(
        id: 'test-id',
        code: 'TEST123',
        description: 'Test coupon',
        amount: 100.0,
        email: 'test@example.com',
        phone: null,
        redeemed: null,
        remainingValue: null,
        originalAmount: null,
      );

      final json = coupon.toJson();
      expect(json.containsKey('phone'), isFalse);
      expect(json.containsKey('redeemed'), isFalse);
      expect(json.containsKey('remainingValue'), isFalse);
      expect(json.containsKey('originalAmount'), isFalse);

      final decoded = Coupon.fromJson(json);
      expect(decoded.phone, isNull);
      expect(decoded.redeemed, isNull);
      expect(decoded.remainingValue, isNull);
      expect(decoded.originalAmount, isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => Coupon.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Coupon.fromJson({
          '_id': 'test',
          'code': 'TEST',
          'description': 'Test',
          'amount': 'not-a-number', // Invalid type
          'email': 'test@example.com',
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Coupon.fromJson({
          '_id': 'test',
          'code': 'TEST',
          'description': 'Test',
          'amount': 100.0,
          'email': 'test@example.com',
          'remainingValue': 'not-a-number', // Invalid optional field type
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => Coupon.fromJson({
          '_id': 'test',
          'code': 'TEST',
          'description': 'Test',
          'amount': 100.0,
          'email': 'test@example.com',
          'originalAmount': 'not-a-number', // Invalid optional field type
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
