// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['_id'] as String,
      cartId: json['cartId'] as String,
      deliveryMethod: json['deliveryMethod'] == null
          ? null
          : DeliveryMethod.fromJson(
              json['deliveryMethod'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
      paymentIntent: json['paymentIntent'] == null
          ? null
          : PaymentIntent.fromJson(
              json['paymentIntent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      '_id': instance.id,
      'cartId': instance.cartId,
      if (instance.deliveryMethod?.toJson() case final value?)
        'deliveryMethod': value,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'userInfo': instance.userInfo.toJson(),
      if (instance.paymentIntent?.toJson() case final value?)
        'paymentIntent': value,
    };

DeliveryMethod _$DeliveryMethodFromJson(Map<String, dynamic> json) =>
    DeliveryMethod(
      service_code: json['service_code'] as String,
      total_price: (json['total_price'] as num).toDouble(),
      service_name: json['service_name'] as String,
    );

Map<String, dynamic> _$DeliveryMethodToJson(DeliveryMethod instance) =>
    <String, dynamic>{
      'service_code': instance.service_code,
      'total_price': instance.total_price,
      'service_name': instance.service_name,
    };

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
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

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
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

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
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

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
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

PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    PaymentIntent(
      object: json['object'] as String,
      id: json['id'] as String,
      amount: (json['amount'] as num).toInt(),
      amount_received: (json['amount_received'] as num).toInt(),
      automatic_payment_methods:
          json['automatic_payment_methods'] as Map<String, dynamic>,
      client_secret: json['client_secret'] as String,
      currency: json['currency'] as String,
      status: json['status'] as String,
      created: (json['created'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>,
      payment_method_types: (json['payment_method_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PaymentIntentToJson(PaymentIntent instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'amount': instance.amount,
      'amount_received': instance.amount_received,
      'automatic_payment_methods': instance.automatic_payment_methods,
      'client_secret': instance.client_secret,
      'currency': instance.currency,
      'status': instance.status,
      'created': instance.created,
      'metadata': instance.metadata,
      'payment_method_types': instance.payment_method_types,
    };
