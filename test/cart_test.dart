import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/src/models/cart.dart';

void main() {
  group('CartModel', () {
    late List<Map<String, dynamic>> sampleData;

    setUpAll(() async {
      final file = File('lib/src/sample_data/carts.json');
      final jsonString = await file.readAsString();
      sampleData = List<Map<String, dynamic>>.from(
          jsonDecode(jsonString) as List<dynamic>);
    });

    test('should successfully deserialize all sample records', () {
      for (final data in sampleData) {
        expect(
          () => CartModel.fromJson(data),
          returnsNormally,
          reason: 'Failed to deserialize record with id: ${data['_id']}',
        );
      }
    });

    test('should serialize and deserialize cart with all fields', () {
      final cart = CartModel(
        id: 'test-id',
        cartId: 'test-cart',
        deliveryMethod: DeliveryMethodModel(
          service_code: 'express',
          total_price: 15.0,
          service_name: 'Express Delivery',
        ),
        products: [
          CartProductModel(
            id: 'prod1',
            name: 'Test Product',
            href: '/products/test',
            volume: 750,
            price: 29.99,
            quantity: 2,
            imageSrc: '/images/test.jpg',
            imageAlt: 'Test Image',
            barcode: 'TEST123',
            stock: 10,
          ),
        ],
        userInfo: UserInfoModel(
          email: 'test@example.com',
          phone: '1234567890',
          firstName: 'John',
          lastName: 'Doe',
          address: '123 Test St',
          apartment: 'Unit 1',
          suburb: 'Testville',
          country: 'Australia',
          state: 'VIC',
          postcode: '3000',
        ),
        paymentIntent: PaymentIntentModel(
          object: 'payment_intent',
          id: 'pi_123',
          amount: 2999,
          amount_received: 2999,
          automatic_payment_methods: {'enabled': true},
          client_secret: 'secret_123',
          currency: 'aud',
          status: 'succeeded',
          created: 1234567890,
          metadata: {'order_id': 'test123'},
          payment_method_types: ['card'],
        ),
      );

      final json = cart.toJson();
      final decoded = CartModel.fromJson(json);

      // Test Cart fields
      expect(decoded.id, equals(cart.id));
      expect(decoded.cartId, equals(cart.cartId));

      // Test DeliveryMethod
      expect(decoded.deliveryMethod?.service_code,
          equals(cart.deliveryMethod?.service_code));
      expect(decoded.deliveryMethod?.total_price,
          equals(cart.deliveryMethod?.total_price));
      expect(decoded.deliveryMethod?.service_name,
          equals(cart.deliveryMethod?.service_name));

      // Test CartProduct
      expect(decoded.products.length, equals(cart.products.length));
      expect(decoded.products[0].id, equals(cart.products[0].id));
      expect(decoded.products[0].name, equals(cart.products[0].name));
      expect(decoded.products[0].href, equals(cart.products[0].href));
      expect(decoded.products[0].volume, equals(cart.products[0].volume));
      expect(decoded.products[0].price, equals(cart.products[0].price));
      expect(decoded.products[0].quantity, equals(cart.products[0].quantity));
      expect(decoded.products[0].imageSrc, equals(cart.products[0].imageSrc));
      expect(decoded.products[0].imageAlt, equals(cart.products[0].imageAlt));
      expect(decoded.products[0].barcode, equals(cart.products[0].barcode));
      expect(decoded.products[0].stock, equals(cart.products[0].stock));

      // Test UserInfo
      expect(decoded.userInfo.email, equals(cart.userInfo.email));
      expect(decoded.userInfo.phone, equals(cart.userInfo.phone));
      expect(decoded.userInfo.firstName, equals(cart.userInfo.firstName));
      expect(decoded.userInfo.lastName, equals(cart.userInfo.lastName));
      expect(decoded.userInfo.address, equals(cart.userInfo.address));
      expect(decoded.userInfo.apartment, equals(cart.userInfo.apartment));
      expect(decoded.userInfo.suburb, equals(cart.userInfo.suburb));
      expect(decoded.userInfo.country, equals(cart.userInfo.country));
      expect(decoded.userInfo.state, equals(cart.userInfo.state));
      expect(decoded.userInfo.postcode, equals(cart.userInfo.postcode));

      // Test PaymentIntent
      expect(decoded.paymentIntent?.object, equals(cart.paymentIntent?.object));
      expect(decoded.paymentIntent?.id, equals(cart.paymentIntent?.id));
      expect(decoded.paymentIntent?.amount, equals(cart.paymentIntent?.amount));
      expect(decoded.paymentIntent?.amount_received,
          equals(cart.paymentIntent?.amount_received));
      expect(decoded.paymentIntent?.automatic_payment_methods,
          equals(cart.paymentIntent?.automatic_payment_methods));
      expect(decoded.paymentIntent?.client_secret,
          equals(cart.paymentIntent?.client_secret));
      expect(decoded.paymentIntent?.currency,
          equals(cart.paymentIntent?.currency));
      expect(decoded.paymentIntent?.status, equals(cart.paymentIntent?.status));
      expect(
          decoded.paymentIntent?.created, equals(cart.paymentIntent?.created));
      expect(decoded.paymentIntent?.metadata,
          equals(cart.paymentIntent?.metadata));
      expect(decoded.paymentIntent?.payment_method_types,
          equals(cart.paymentIntent?.payment_method_types));
    });

    test('should handle cart with minimal fields', () {
      final cart = CartModel(
        id: 'test-id',
        cartId: 'test-cart',
        products: [],
        userInfo: UserInfoModel(
          email: 'test@example.com',
          phone: '1234567890',
          firstName: 'John',
          lastName: 'Doe',
          address: '123 Test St',
          apartment: 'Unit 1',
          suburb: 'Testville',
          country: 'Australia',
          state: 'VIC',
          postcode: '3000',
        ),
      );

      final json = cart.toJson();
      final decoded = CartModel.fromJson(json);

      expect(decoded.id, equals(cart.id));
      expect(decoded.cartId, equals(cart.cartId));
      expect(decoded.deliveryMethod, isNull);
      expect(decoded.products, isEmpty);
      expect(decoded.paymentIntent, isNull);
    });

    test('Invalid JSON handling', () {
      expect(
        () => CartModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => CartModel.fromJson({
          '_id': 'test',
          'cartId': 'test',
          'products': [
            {'invalid': 'product'}
          ],
          'userInfo': {'invalid': 'user'},
        }),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => DeliveryMethodModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => CartProductModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => UserInfoModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );

      expect(
        () => PaymentIntentModel.fromJson({'invalid': 'data'}),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
