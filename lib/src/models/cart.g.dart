// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
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
      paymentIntent: json['paymentIntent'] == null
          ? null
          : PaymentIntentModel.fromJson(
              json['paymentIntent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
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
      serviceCode: json['service_code'] as String,
      totalPrice: (json['total_price'] as num).toDouble(),
      serviceName: json['service_name'] as String,
    );

Map<String, dynamic> _$DeliveryMethodModelToJson(
        DeliveryMethodModel instance) =>
    <String, dynamic>{
      'service_code': instance.serviceCode,
      'total_price': instance.totalPrice,
      'service_name': instance.serviceName,
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
      amountReceived: (json['amount_received'] as num).toInt(),
      automaticPaymentMethods:
          json['automatic_payment_methods'] as Map<String, dynamic>,
      clientSecret: json['client_secret'] as String,
      currency: json['currency'] as String,
      status: json['status'] as String,
      created: (json['created'] as num).toInt(),
      metadata: json['metadata'] as Map<String, dynamic>,
      paymentMethodTypes: (json['payment_method_types'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PaymentIntentModelToJson(PaymentIntentModel instance) =>
    <String, dynamic>{
      'object': instance.object,
      'id': instance.id,
      'amount': instance.amount,
      'amount_received': instance.amountReceived,
      'automatic_payment_methods': instance.automaticPaymentMethods,
      'client_secret': instance.clientSecret,
      'currency': instance.currency,
      'status': instance.status,
      'created': instance.created,
      'metadata': instance.metadata,
      'payment_method_types': instance.paymentMethodTypes,
    };
