import 'package:json_annotation/json_annotation.dart';

part 'starshipit_create_order_response_model.g.dart';

/// Response model for StarShipIt create order API
@JsonSerializable()
class StarShipItCreateOrderResponse {
  /// The created order details
  final StarShipItOrderResponse order;

  /// Whether the operation was successful
  final bool success;

  const StarShipItCreateOrderResponse({
    required this.order,
    required this.success,
  });

  factory StarShipItCreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$StarShipItCreateOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItCreateOrderResponseToJson(this);
}

/// StarShipIt order response model containing created order details
@JsonSerializable()
class StarShipItOrderResponse {
  /// The unique order ID assigned by StarShipIt
  @JsonKey(name: 'order_id')
  final int orderId;

  /// The date when the order was created in UTC
  @JsonKey(name: 'order_date')
  final DateTime orderDate;

  /// The identifier of the order pulled from source e-Commerce platform
  @JsonKey(name: 'order_number')
  final String orderNumber;

  /// Customer's reference
  final String? reference;

  /// Carrier code
  final String? carrier;

  /// Carrier display name
  @JsonKey(name: 'carrier_name')
  final String? carrierName;

  /// Carrier's service code
  @JsonKey(name: 'carrier_service_code')
  final String? carrierServiceCode;

  /// Delivery method name
  @JsonKey(name: 'shipping_method')
  final String? shippingMethod;

  /// Whether signature is required on delivery
  @JsonKey(name: 'signature_required')
  final bool? signatureRequired;

  /// Whether the shipment contains dangerous goods
  @JsonKey(name: 'dangerous_goods')
  final bool? dangerousGoods;

  /// Shipping address and contact details
  final StarShipItAddressResponse destination;

  /// Item list containing the order item details
  final List<StarShipItItemResponse>? items;

  /// Package list containing the parcel details
  final List<StarShipItPackageResponse>? packages;

  /// Declared value of the shipment
  @JsonKey(name: 'declared_value')
  final double? declaredValue;

  const StarShipItOrderResponse({
    required this.orderId,
    required this.orderDate,
    required this.orderNumber,
    this.reference,
    this.carrier,
    this.carrierName,
    this.carrierServiceCode,
    this.shippingMethod,
    this.signatureRequired,
    this.dangerousGoods,
    required this.destination,
    this.items,
    this.packages,
    this.declaredValue,
  });

  factory StarShipItOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$StarShipItOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItOrderResponseToJson(this);
}

/// Address and contact details for StarShipIt order responses
@JsonSerializable()
class StarShipItAddressResponse {
  /// Contact name
  final String name;

  /// Contact phone number
  final String phone;

  /// Street address
  final String street;

  /// Suburb/city
  final String suburb;

  /// State/province
  final String state;

  /// Postal/zip code
  @JsonKey(name: 'post_code')
  final String postCode;

  /// Country name
  final String country;

  /// Special delivery instructions
  @JsonKey(name: 'delivery_instructions')
  final String? deliveryInstructions;

  const StarShipItAddressResponse({
    required this.name,
    required this.phone,
    required this.street,
    required this.suburb,
    required this.state,
    required this.postCode,
    required this.country,
    this.deliveryInstructions,
  });

  factory StarShipItAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$StarShipItAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItAddressResponseToJson(this);
}

/// Item details for StarShipIt order responses
@JsonSerializable()
class StarShipItItemResponse {
  /// Unique item identifier
  @JsonKey(name: 'item_id')
  final int itemId;

  /// Product name or description
  final String description;

  /// Product code or SKU
  final String sku;

  /// The number of product ordered
  final double quantity;

  /// The number of product to ship
  @JsonKey(name: 'quantity_to_ship')
  final double quantityToShip;

  /// Unit weight of the product in kilograms (kg)
  final double weight;

  /// Unit price of the product
  final double value;

  const StarShipItItemResponse({
    required this.itemId,
    required this.description,
    required this.sku,
    required this.quantity,
    required this.quantityToShip,
    required this.weight,
    required this.value,
  });

  factory StarShipItItemResponse.fromJson(Map<String, dynamic> json) =>
      _$StarShipItItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItItemResponseToJson(this);
}

/// Package details for StarShipIt order responses
@JsonSerializable()
class StarShipItPackageResponse {
  /// Unique package identifier assigned by StarShipIt
  @JsonKey(name: 'package_id')
  final int packageId;

  /// Physical weight of the parcel in kilograms (kg)
  final double weight;

  /// Height of the parcel in meters (m)
  final double height;

  /// Width of the parcel in meters (m)
  final double width;

  /// Length of the parcel in meters (m)
  final double length;

  const StarShipItPackageResponse({
    required this.packageId,
    required this.weight,
    required this.height,
    required this.width,
    required this.length,
  });

  factory StarShipItPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$StarShipItPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItPackageResponseToJson(this);
}
