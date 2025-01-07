import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: '_id')
  final String id;
  final String cartId;
  final DeliveryMethod? deliveryMethod;
  final List<CartProduct> products;
  final UserInfo userInfo;
  final PaymentIntent? paymentIntent;

  const Cart({
    required this.id,
    required this.cartId,
    this.deliveryMethod,
    required this.products,
    required this.userInfo,
    this.paymentIntent,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

@JsonSerializable()
class DeliveryMethod {
  final String service_code;
  final double total_price;
  final String service_name;

  const DeliveryMethod({
    required this.service_code,
    required this.total_price,
    required this.service_name,
  });

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) =>
      _$DeliveryMethodFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryMethodToJson(this);
}

@JsonSerializable()
class CartProduct {
  final String id;
  final String name;
  final String href;
  final int volume;
  final double price;
  final int quantity;
  final String imageSrc;
  final String imageAlt;
  final String barcode;
  final int stock;

  const CartProduct({
    required this.id,
    required this.name,
    required this.href,
    required this.volume,
    required this.price,
    required this.quantity,
    required this.imageSrc,
    required this.imageAlt,
    required this.barcode,
    required this.stock,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String address;
  final String apartment;
  final String suburb;
  final String country;
  final String state;
  final String postcode;

  const UserInfo({
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.apartment,
    required this.suburb,
    required this.country,
    required this.state,
    required this.postcode,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class PaymentIntent {
  final String object;
  final String id;
  final int amount;
  final int amount_received;
  final Map<String, dynamic> automatic_payment_methods;
  final String client_secret;
  final String currency;
  final String status;
  final int created;
  final Map<String, dynamic> metadata;
  final List<String> payment_method_types;

  const PaymentIntent({
    required this.object,
    required this.id,
    required this.amount,
    required this.amount_received,
    required this.automatic_payment_methods,
    required this.client_secret,
    required this.currency,
    required this.status,
    required this.created,
    required this.metadata,
    required this.payment_method_types,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentToJson(this);
}
