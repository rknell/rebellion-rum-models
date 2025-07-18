import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('CartModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _\$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      cartId: json['cartId'] as String,
      deliveryMethod: json['deliveryMethod'] == null
          ? null
          : DeliveryMethodModel.fromJson(
              json['deliveryMethod'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userInfo:
          UserInfoModel.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _\$CartModelToJson(CartModel instance) => <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'cartId': instance.cartId,
      if (instance.deliveryMethod?.toJson() case final value?)
        'deliveryMethod': value,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'userInfo': instance.userInfo.toJson(),
    };

DeliveryMethodModel _\$DeliveryMethodModelFromJson(Map<String, dynamic> json) =>
    DeliveryMethodModel(
      serviceCode: json['service_code'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      serviceName: json['service_name'] as String,
    );

Map<String, dynamic> _\$DeliveryMethodModelToJson(
        DeliveryMethodModel instance) =>
    <String, dynamic>{
      'service_code': instance.serviceCode,
      'total_price': instance.totalPrice,
      'service_name': instance.serviceName,
    };

CartProductModel _\$CartProductModelFromJson(Map<String, dynamic> json) =>
    CartProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      href: json['href'] as String,
      volume: (json['volume'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      imageSrc: json['imageSrc'] as String,
      imageAlt: json['imageAlt'] as String,
      barcode: json['barcode'] as String,
      stock: (json['stock'] as num).toInt(),
    );

Map<String, dynamic> _\$CartProductModelToJson(CartProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'href': instance.href,
      'volume': instance.volume,
      'price': instance.price,
      'quantity': instance.quantity,
      'imageSrc': instance.imageSrc,
      'imageAlt': instance.imageAlt,
      'barcode': instance.barcode,
      'stock': instance.stock,
    };

UserInfoModel _\$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      email: json['email'] as String,
      phone: json['phone'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      address: json['address'] as String,
      apartment: json['apartment'] as String,
      suburb: json['suburb'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
    );

Map<String, dynamic> _\$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'apartment': instance.apartment,
      'suburb': instance.suburb,
      'country': instance.country,
      'state': instance.state,
      'postcode': instance.postcode,
    };
''';

    test(
        'should contain fromJson function with all required fields for CartModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);

      expect(
        result.contains('export interface CartModel'),
        isTrue,
        reason: 'Generated TypeScript should contain the CartModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('_id: string'), isTrue);
      expect(result.contains('cartId: string'), isTrue);
      expect(result.contains('deliveryMethod: DeliveryMethodModel | null'),
          isTrue);
      expect(result.contains('products: CartProductModel[]'), isTrue);
      expect(result.contains('userInfo: UserInfoModel'), isTrue);
    });

    test('should contain sub-models in the generated TypeScript', () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);

      // Check for DeliveryMethodModel
      expect(
        result.contains('export interface DeliveryMethodModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the DeliveryMethodModel interface',
      );
      expect(result.contains('service_code: string'), isTrue);
      expect(result.contains('total_price: number'), isTrue);
      expect(result.contains('service_name: string'), isTrue);

      // Check for CartProductModel
      expect(
        result.contains('export interface CartProductModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the CartProductModel interface',
      );
      expect(result.contains('id: string'), isTrue);
      expect(result.contains('name: string'), isTrue);
      expect(result.contains('volume: number'), isTrue);
      expect(result.contains('price: number'), isTrue);
      expect(result.contains('quantity: number'), isTrue);

      // Check for UserInfoModel
      expect(
        result.contains('export interface UserInfoModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the UserInfoModel interface',
      );
      expect(result.contains('email: string'), isTrue);
      expect(result.contains('phone: string'), isTrue);
      expect(result.contains('firstName: string'), isTrue);
      expect(result.contains('address: string'), isTrue);
    });
  });
}
