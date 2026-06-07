import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('Storefront scoped models', () {
    test('OrderModel serializes storefront identity', () {
      final order = OrderModel(
        customerId: null,
        items: {'FH-SOUR-001': 2},
        orderNumber: 'FH-1001',
        paymentMethod: 'card',
        shippingMethod: 'P',
        storefrontId: 'fuckhead',
        sourceDomain: 'fuckhead.com.au',
      );

      final json = order.toJson();
      expect(json['storefrontId'], equals('fuckhead'));
      expect(json['sourceDomain'], equals('fuckhead.com.au'));

      final deserialized = OrderModel.fromJson(json);
      expect(deserialized.storefrontId, equals('fuckhead'));
      expect(deserialized.sourceDomain, equals('fuckhead.com.au'));
    });

    test('OrderModel defaults legacy orders to Rebellion', () {
      final order = OrderModel.fromJson({
        'customerId': null,
        'items': {'3531954279220': 1},
        'orderNumber': 'RR-1001',
        'paymentMethod': 'card',
      });

      expect(order.storefrontId, equals('rebellion'));
      expect(order.sourceDomain, isNull);
    });

    test('CouponModel serializes storefrontIds', () {
      final coupon = CouponModel(
        code: 'FH10',
        description: 'Fuckhead launch coupon',
        amount: 10,
        email: null,
        storefrontIds: const ['fuckhead'],
      );

      final json = coupon.toJson();
      expect(json['storefrontIds'], equals(['fuckhead']));

      final deserialized = CouponModel.fromJson(json);
      expect(deserialized.storefrontIds, equals(['fuckhead']));
    });

    test('CouponModel defaults legacy coupons to Rebellion', () {
      final coupon = CouponModel.fromJson({
        'code': 'RR10',
        'description': 'Legacy coupon',
        'amount': 10,
        'email': null,
      });

      expect(coupon.storefrontIds, equals(['rebellion']));
    });

    test('NewsletterSignupModel serializes storefrontId', () {
      final signup = NewsletterSignupModel(
        contactInfo: 'fan@fuckhead.com.au',
        storefrontId: 'fuckhead',
      );

      final json = signup.toJson();
      expect(json['storefrontId'], equals('fuckhead'));

      final deserialized = NewsletterSignupModel.fromJson(json);
      expect(deserialized.storefrontId, equals('fuckhead'));
    });

    test('NewsletterSignupModel defaults legacy signups to Rebellion', () {
      final signup = NewsletterSignupModel.fromJson({
        'contactInfo': 'legacy@example.com',
      });

      expect(signup.storefrontId, equals('rebellion'));
    });
  });
}
