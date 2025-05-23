import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('StarShipIt Create Order Request Model Tests', () {
    test('serializes to JSON correctly', () {
      final address = StarShipItAddress(
        name: 'Johnny Smith',
        phone: '0290988227',
        street: '20 George Street',
        suburb: 'Sydney',
        state: 'NSW',
        postCode: '2000',
        country: 'Australia',
        deliveryInstructions: 'Leave at door',
      );

      final item = StarShipItItem(
        itemId: 1065580746,
        description: 'Mobile Phone',
        sku: 'MOBILE',
        quantity: 1.0,
        quantityToShip: 0.0,
        weight: 0.65,
        value: 125.0,
      );

      final order = StarShipItOrder(
        orderNumber: '1747968265',
        reference: 'Online Order',
        carrier: 'AusPost',
        carrierName: 'Australia Post',
        shippingMethod: 'Return Express Shipping',
        signatureRequired: false,
        returnOrder: false,
        destination: address,
        items: [item],
      );

      final request = StarShipItCreateOrderRequest(order: order);

      final json = request.toJson();

      expect(json['order']['order_number'], equals('1747968265'));
      expect(json['order']['reference'], equals('Online Order'));
      expect(json['order']['carrier'], equals('AusPost'));
      expect(json['order']['carrier_name'], equals('Australia Post'));
      expect(
          json['order']['shipping_method'], equals('Return Express Shipping'));
      expect(json['order']['signature_required'], equals(false));
      expect(json['order']['return_order'], equals(false));

      expect(json['order']['destination']['name'], equals('Johnny Smith'));
      expect(json['order']['destination']['phone'], equals('0290988227'));
      expect(
          json['order']['destination']['street'], equals('20 George Street'));
      expect(json['order']['destination']['suburb'], equals('Sydney'));
      expect(json['order']['destination']['state'], equals('NSW'));
      expect(json['order']['destination']['post_code'], equals('2000'));
      expect(json['order']['destination']['country'], equals('Australia'));
      expect(json['order']['destination']['delivery_instructions'],
          equals('Leave at door'));

      expect(json['order']['items'][0]['item_id'], equals(1065580746));
      expect(json['order']['items'][0]['description'], equals('Mobile Phone'));
      expect(json['order']['items'][0]['sku'], equals('MOBILE'));
      expect(json['order']['items'][0]['quantity'], equals(1.0));
      expect(json['order']['items'][0]['quantity_to_ship'], equals(0.0));
      expect(json['order']['items'][0]['weight'], equals(0.65));
      expect(json['order']['items'][0]['value'], equals(125.0));
    });

    test('deserializes from JSON correctly', () {
      final json = {
        'order': {
          'order_number': '1747968265',
          'reference': 'Online Order',
          'carrier': 'AusPost',
          'carrier_name': 'Australia Post',
          'shipping_method': 'Return Express Shipping',
          'signature_required': false,
          'return_order': false,
          'destination': {
            'name': 'Johnny Smith',
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
              'quantity': 1.0,
              'quantity_to_ship': 0.0,
              'weight': 0.65,
              'value': 125.0,
            }
          ],
        }
      };

      final request = StarShipItCreateOrderRequest.fromJson(json);

      expect(request.order.orderNumber, equals('1747968265'));
      expect(request.order.reference, equals('Online Order'));
      expect(request.order.carrier, equals('AusPost'));
      expect(request.order.carrierName, equals('Australia Post'));
      expect(request.order.shippingMethod, equals('Return Express Shipping'));
      expect(request.order.signatureRequired, equals(false));
      expect(request.order.returnOrder, equals(false));

      expect(request.order.destination.name, equals('Johnny Smith'));
      expect(request.order.destination.phone, equals('0290988227'));
      expect(request.order.destination.street, equals('20 George Street'));
      expect(request.order.destination.suburb, equals('Sydney'));
      expect(request.order.destination.state, equals('NSW'));
      expect(request.order.destination.postCode, equals('2000'));
      expect(request.order.destination.country, equals('Australia'));
      expect(request.order.destination.deliveryInstructions,
          equals('Leave at door'));

      expect(request.order.items, hasLength(1));
      expect(request.order.items![0].itemId, equals(1065580746));
      expect(request.order.items![0].description, equals('Mobile Phone'));
      expect(request.order.items![0].sku, equals('MOBILE'));
      expect(request.order.items![0].quantity, equals(1.0));
      expect(request.order.items![0].quantityToShip, equals(0.0));
      expect(request.order.items![0].weight, equals(0.65));
      expect(request.order.items![0].value, equals(125.0));
    });

    test('handles optional fields correctly', () {
      final minimalOrder = StarShipItOrder(
        orderNumber: 'MIN123',
        destination: StarShipItAddress(
          name: 'Test User',
          phone: '1234567890',
          street: 'Test Street',
          suburb: 'Test City',
          state: 'Test State',
          postCode: '12345',
          country: 'Test Country',
        ),
      );

      final request = StarShipItCreateOrderRequest(order: minimalOrder);
      final json = request.toJson();

      expect(json['order']['order_number'], equals('MIN123'));
      expect(json['order']['reference'], isNull);
      expect(json['order']['carrier'], isNull);
      expect(json['order']['items'], isNull);
      expect(json['order']['packages'], isNull);
    });

    test('StarShipItPackage serializes correctly', () {
      final package = StarShipItPackage(
        weight: 1.5,
        height: 0.3,
        width: 0.2,
        length: 0.4,
      );

      final json = package.toJson();

      expect(json['weight'], equals(1.5));
      expect(json['height'], equals(0.3));
      expect(json['width'], equals(0.2));
      expect(json['length'], equals(0.4));

      final deserializedPackage = StarShipItPackage.fromJson(json);

      expect(deserializedPackage.weight, equals(1.5));
      expect(deserializedPackage.height, equals(0.3));
      expect(deserializedPackage.width, equals(0.2));
      expect(deserializedPackage.length, equals(0.4));
    });
  });
}
