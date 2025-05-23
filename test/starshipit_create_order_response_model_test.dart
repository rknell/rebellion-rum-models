import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('StarShipIt Create Order Response Model Tests', () {
    test('deserializes from JSON correctly', () {
      final json = {
        'order': {
          'order_id': 1020304051,
          'order_date': '2020-04-29T22:47:00.0593501Z',
          'order_number': '10001',
          'reference': 'Online Order',
          'carrier': 'AusPost',
          'carrier_name': 'Australia Post',
          'carrier_service_code': '7B05',
          'shipping_method': 'Express Shipping',
          'signature_required': false,
          'dangerous_goods': false,
          'destination': {
            'name': 'John Smith',
            'phone': '0290988227',
            'street': '20 George Street',
            'suburb': 'Sydney',
            'state': 'NSW',
            'post_code': '2000',
            'country': 'Australia',
            'delivery_instructions': 'Leave at door',
          },
          'items': [
            {
              'item_id': 1065580746,
              'description': 'Mobile Phone',
              'sku': 'MOBILE',
              'quantity': 1,
              'quantity_to_ship': 0,
              'weight': 0.65,
              'value': 125,
            },
            {
              'item_id': 1065580747,
              'description': 'Mobile Case (Black)',
              'sku': 'MOBILE-CASE-BLK',
              'quantity': 1,
              'quantity_to_ship': 0,
              'weight': 0.05,
              'value': 20,
            }
          ],
          'packages': [
            {
              'package_id': 1035548017,
              'weight': 0.7,
              'height': 0.04,
              'width': 0.08,
              'length': 0.12,
            }
          ],
          'declared_value': 0,
        },
        'success': true,
      };

      final response = StarShipItCreateOrderResponse.fromJson(json);

      expect(response.success, equals(true));
      expect(response.order.orderId, equals(1020304051));
      expect(response.order.orderDate,
          equals(DateTime.parse('2020-04-29T22:47:00.0593501Z')));
      expect(response.order.orderNumber, equals('10001'));
      expect(response.order.reference, equals('Online Order'));
      expect(response.order.carrier, equals('AusPost'));
      expect(response.order.carrierName, equals('Australia Post'));
      expect(response.order.carrierServiceCode, equals('7B05'));
      expect(response.order.shippingMethod, equals('Express Shipping'));
      expect(response.order.signatureRequired, equals(false));
      expect(response.order.dangerousGoods, equals(false));
      expect(response.order.declaredValue, equals(0.0));

      expect(response.order.destination.name, equals('John Smith'));
      expect(response.order.destination.phone, equals('0290988227'));
      expect(response.order.destination.street, equals('20 George Street'));
      expect(response.order.destination.suburb, equals('Sydney'));
      expect(response.order.destination.state, equals('NSW'));
      expect(response.order.destination.postCode, equals('2000'));
      expect(response.order.destination.country, equals('Australia'));
      expect(response.order.destination.deliveryInstructions,
          equals('Leave at door'));

      expect(response.order.items, hasLength(2));

      final firstItem = response.order.items![0];
      expect(firstItem.itemId, equals(1065580746));
      expect(firstItem.description, equals('Mobile Phone'));
      expect(firstItem.sku, equals('MOBILE'));
      expect(firstItem.quantity, equals(1.0));
      expect(firstItem.quantityToShip, equals(0.0));
      expect(firstItem.weight, equals(0.65));
      expect(firstItem.value, equals(125.0));

      final secondItem = response.order.items![1];
      expect(secondItem.itemId, equals(1065580747));
      expect(secondItem.description, equals('Mobile Case (Black)'));
      expect(secondItem.sku, equals('MOBILE-CASE-BLK'));
      expect(secondItem.quantity, equals(1.0));
      expect(secondItem.quantityToShip, equals(0.0));
      expect(secondItem.weight, equals(0.05));
      expect(secondItem.value, equals(20.0));

      expect(response.order.packages, hasLength(1));

      final package = response.order.packages![0];
      expect(package.packageId, equals(1035548017));
      expect(package.weight, equals(0.7));
      expect(package.height, equals(0.04));
      expect(package.width, equals(0.08));
      expect(package.length, equals(0.12));
    });

    test('serializes to JSON correctly', () {
      final addressResponse = StarShipItAddressResponse(
        name: 'John Smith',
        phone: '0290988227',
        street: '20 George Street',
        suburb: 'Sydney',
        state: 'NSW',
        postCode: '2000',
        country: 'Australia',
        deliveryInstructions: 'Leave at door',
      );

      final itemResponse = StarShipItItemResponse(
        itemId: 1065580746,
        description: 'Mobile Phone',
        sku: 'MOBILE',
        quantity: 1.0,
        quantityToShip: 0.0,
        weight: 0.65,
        value: 125.0,
      );

      final packageResponse = StarShipItPackageResponse(
        packageId: 1035548017,
        weight: 0.7,
        height: 0.04,
        width: 0.08,
        length: 0.12,
      );

      final orderResponse = StarShipItOrderResponse(
        orderId: 1020304051,
        orderDate: DateTime.parse('2020-04-29T22:47:00.0593501Z'),
        orderNumber: '10001',
        reference: 'Online Order',
        carrier: 'AusPost',
        carrierName: 'Australia Post',
        carrierServiceCode: '7B05',
        shippingMethod: 'Express Shipping',
        signatureRequired: false,
        dangerousGoods: false,
        destination: addressResponse,
        items: [itemResponse],
        packages: [packageResponse],
        declaredValue: 0.0,
      );

      final response = StarShipItCreateOrderResponse(
        order: orderResponse,
        success: true,
      );

      final json = response.toJson();

      expect(json['success'], equals(true));
      expect(json['order']['order_id'], equals(1020304051));
      expect(
          json['order']['order_date'], startsWith('2020-04-29T22:47:00.059'));
      expect(json['order']['order_number'], equals('10001'));
      expect(json['order']['reference'], equals('Online Order'));
      expect(json['order']['carrier'], equals('AusPost'));
      expect(json['order']['carrier_name'], equals('Australia Post'));
      expect(json['order']['carrier_service_code'], equals('7B05'));
      expect(json['order']['shipping_method'], equals('Express Shipping'));
      expect(json['order']['signature_required'], equals(false));
      expect(json['order']['dangerous_goods'], equals(false));
      expect(json['order']['declared_value'], equals(0.0));

      expect(json['order']['destination']['name'], equals('John Smith'));
      expect(json['order']['destination']['phone'], equals('0290988227'));
      expect(
          json['order']['destination']['street'], equals('20 George Street'));
      expect(json['order']['destination']['suburb'], equals('Sydney'));
      expect(json['order']['destination']['state'], equals('NSW'));
      expect(json['order']['destination']['post_code'], equals('2000'));
      expect(json['order']['destination']['country'], equals('Australia'));
      expect(json['order']['destination']['delivery_instructions'],
          equals('Leave at door'));

      expect(json['order']['items'], hasLength(1));
      expect(json['order']['items'][0]['item_id'], equals(1065580746));
      expect(json['order']['items'][0]['description'], equals('Mobile Phone'));
      expect(json['order']['items'][0]['sku'], equals('MOBILE'));
      expect(json['order']['items'][0]['quantity'], equals(1.0));
      expect(json['order']['items'][0]['quantity_to_ship'], equals(0.0));
      expect(json['order']['items'][0]['weight'], equals(0.65));
      expect(json['order']['items'][0]['value'], equals(125.0));

      expect(json['order']['packages'], hasLength(1));
      expect(json['order']['packages'][0]['package_id'], equals(1035548017));
      expect(json['order']['packages'][0]['weight'], equals(0.7));
      expect(json['order']['packages'][0]['height'], equals(0.04));
      expect(json['order']['packages'][0]['width'], equals(0.08));
      expect(json['order']['packages'][0]['length'], equals(0.12));
    });

    test('handles minimal response correctly', () {
      final json = {
        'order': {
          'order_id': 12345,
          'order_date': '2023-01-01T00:00:00.000Z',
          'order_number': 'MIN123',
          'destination': {
            'name': 'Test User',
            'phone': '1234567890',
            'street': 'Test Street',
            'suburb': 'Test City',
            'state': 'Test State',
            'post_code': '12345',
            'country': 'Test Country',
          },
        },
        'success': true,
      };

      final response = StarShipItCreateOrderResponse.fromJson(json);

      expect(response.success, equals(true));
      expect(response.order.orderId, equals(12345));
      expect(response.order.orderNumber, equals('MIN123'));
      expect(response.order.reference, isNull);
      expect(response.order.carrier, isNull);
      expect(response.order.items, isNull);
      expect(response.order.packages, isNull);
      expect(response.order.declaredValue, isNull);
    });
  });
}
