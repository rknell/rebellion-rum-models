// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      id: json['_id'] as String,
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
      paymentIntent: json['paymentIntent'] == null
          ? null
          : PaymentIntentModel.fromJson(
              json['paymentIntent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      '_id': instance.id,
      'cartId': instance.cartId,
      if (instance.deliveryMethod?.toJson() case final value?)
        'deliveryMethod': value,
      'products': instance.products.map((e) => e.toJson()).toList(),
      'userInfo': instance.userInfo.toJson(),
      if (instance.paymentIntent?.toJson() case final value?)
        'paymentIntent': value,
    };

DeliveryMethodModel _$DeliveryMethodModelFromJson(Map<String, dynamic> json) =>
    DeliveryMethodModel(
      service_code: json['service_code'] as String,
      total_price: (json['total_price'] as num).toDouble(),
      service_name: json['service_name'] as String,
    );

Map<String, dynamic> _$DeliveryMethodModelToJson(
        DeliveryMethodModel instance) =>
    <String, dynamic>{
      'service_code': instance.service_code,
      'total_price': instance.total_price,
      'service_name': instance.service_name,
    };

CartProductModel _$CartProductModelFromJson(Map<String, dynamic> json) =>
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

Map<String, dynamic> _$CartProductModelToJson(CartProductModel instance) =>
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

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
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

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
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

PaymentIntentModel _$PaymentIntentModelFromJson(Map<String, dynamic> json) =>
    PaymentIntentModel(
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

Map<String, dynamic> _$PaymentIntentModelToJson(PaymentIntentModel instance) =>
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
