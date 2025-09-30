import 'package:json_annotation/json_annotation.dart';

part 'starshipit_create_order_request_model.g.dart';

/// Main request model for creating a StarShipIt order
@JsonSerializable()
class StarShipItCreateOrderRequest {
  /// The order details to create
  final StarShipItOrder order;

  const StarShipItCreateOrderRequest({
    required this.order,
  });

  factory StarShipItCreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$StarShipItCreateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItCreateOrderRequestToJson(this);
}

/// StarShipIt order model containing all order details
@JsonSerializable()
class StarShipItOrder {
  /// The date when the order was created in UTC (optional)
  @JsonKey(name: 'order_date')
  final DateTime? orderDate;

  /// The identifier of the order pulled from source e-Commerce platform (max length: 50)
  @JsonKey(name: 'order_number')
  final String orderNumber;

  /// Customer's reference (max length: 50) (optional)
  final String? reference;

  /// Carrier code (optional)
  final String? carrier;

  /// Carrier display name (optional)
  @JsonKey(name: 'carrier_name')
  final String? carrierName;

  /// Delivery method name (max length: 100) (optional)
  @JsonKey(name: 'shipping_method')
  final String? shippingMethod;

  /// Delivery method description (max length: 100) (optional)
  @JsonKey(name: 'shipping_description')
  final String? shippingDescription;

  /// Determine whether signature is needed on delivery (optional)
  @JsonKey(name: 'signature_required')
  final bool? signatureRequired;

  /// If true, only the return label will be generated (optional)
  @JsonKey(name: 'return_order')
  final bool? returnOrder;

  /// Currency code for the order value (max length: 3) e.g. AUD (optional)
  final String? currency;

  /// Sender address and contact details (optional)
  @JsonKey(name: 'sender_details')
  final StarShipItAddress? senderDetails;

  /// Shipping address and contact details (required)
  final StarShipItAddress destination;

  /// Item list containing the order item details (optional)
  final List<StarShipItItem>? items;

  /// Package list containing the parcel details (optional)
  final List<StarShipItPackage>? packages;

  const StarShipItOrder({
    this.orderDate,
    required this.orderNumber,
    this.reference,
    this.carrier,
    this.carrierName,
    this.shippingMethod,
    this.shippingDescription,
    this.signatureRequired,
    this.returnOrder,
    this.currency,
    this.senderDetails,
    required this.destination,
    this.items,
    this.packages,
  });

  factory StarShipItOrder.fromJson(Map<String, dynamic> json) =>
      _$StarShipItOrderFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItOrderToJson(this);
}

/// Address and contact details for StarShipIt orders
@JsonSerializable()
class StarShipItAddress {
  /// Contact name of the receiver (max length: 100)
  final String name;

  /// Contact email address of the receiver (max length: 100) (optional)
  final String? email;

  /// Contact phone number of the receiver (max length: 100) (optional)
  final String? phone;

  /// Building name of the delivery address (max length: 100) (optional)
  final String? building;

  /// Name of company that the parcel is being delivered to (max length: 100) (optional)
  final String? company;

  /// Street number and name of the delivery address (max length: 100)
  final String street;

  /// Suburb of the delivery address (max length: 100)
  final String suburb;

  /// City of the delivery address (max length: 100) (optional)
  final String? city;

  /// Regional, provincial or county name of the delivery address (max length: 100) (optional)
  final String? state;

  /// Postal or zip code of the delivery address (max length: 10) (optional)
  @JsonKey(name: 'post_code')
  final String? postCode;

  /// The country name of delivery address (min length: 2, max length: 100)
  final String country;

  /// Delivery instructions for courier (max length: 100) (optional)
  @JsonKey(name: 'delivery_instructions')
  final String? deliveryInstructions;

  /// List of receiver tax numbers (optional)
  @JsonKey(name: 'tax_numbers')
  final List<String>? taxNumbers;

  /// Recipient tax number (max length: 20) (optional)
  @JsonKey(name: 'tax_number')
  final String? taxNumber;

  const StarShipItAddress({
    required this.name,
    this.email,
    this.phone,
    this.building,
    this.company,
    required this.street,
    required this.suburb,
    this.city,
    this.state,
    this.postCode,
    required this.country,
    this.deliveryInstructions,
    this.taxNumbers,
    this.taxNumber,
  });

  factory StarShipItAddress.fromJson(Map<String, dynamic> json) =>
      _$StarShipItAddressFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItAddressToJson(this);
}

/// Item details for StarShipIt orders
@JsonSerializable()
class StarShipItItem {
  /// Unique item identifier (optional)
  @JsonKey(name: 'item_id')
  final int? itemId;

  /// Product name or description (optional)
  final String? description;

  /// Product code or SKU (max length: 50) (optional)
  final String? sku;

  /// The harmonized system code that indicates the type of this order item (max length: 18) (optional)
  @JsonKey(name: 'tariff_code')
  final String? tariffCode;

  /// The country in which this item was manufactured (max length: 50) (optional)
  @JsonKey(name: 'country_of_origin')
  final String? countryOfOrigin;

  /// The number of product ordered (optional)
  final double? quantity;

  /// The number of product to ship (optional)
  @JsonKey(name: 'quantity_to_ship')
  final double? quantityToShip;

  /// Unit weight of the product in kilograms (kg) (optional)
  final double? weight;

  /// Unit price of the product (optional)
  final double? value;

  const StarShipItItem({
    this.itemId,
    this.description,
    this.sku,
    this.tariffCode,
    this.countryOfOrigin,
    this.quantity,
    this.quantityToShip,
    this.weight,
    this.value,
  });

  factory StarShipItItem.fromJson(Map<String, dynamic> json) =>
      _$StarShipItItemFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItItemToJson(this);
}

/// Package details for StarShipIt orders
@JsonSerializable()
class StarShipItPackage {
  /// Physical weight of the parcel in kilograms (kg) (optional)
  final double? weight;

  /// Height of the parcel in meters (m) (optional)
  final double? height;

  /// Width of the parcel in meters (m) (optional)
  final double? width;

  /// Length of the parcel in meters (m) (optional)
  final double? length;

  const StarShipItPackage({
    this.weight,
    this.height,
    this.width,
    this.length,
  });

  factory StarShipItPackage.fromJson(Map<String, dynamic> json) =>
      _$StarShipItPackageFromJson(json);

  Map<String, dynamic> toJson() => _$StarShipItPackageToJson(this);
}
