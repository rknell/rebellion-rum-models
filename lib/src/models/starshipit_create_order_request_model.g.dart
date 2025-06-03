// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starshipit_create_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarShipItCreateOrderRequest _$StarShipItCreateOrderRequestFromJson(
        Map<String, dynamic> json) =>
    StarShipItCreateOrderRequest(
      order: StarShipItOrder.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StarShipItCreateOrderRequestToJson(
        StarShipItCreateOrderRequest instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
    };

StarShipItOrder _$StarShipItOrderFromJson(Map<String, dynamic> json) =>
    StarShipItOrder(
      orderDate: json['order_date'] == null
          ? null
          : DateTime.parse(json['order_date'] as String),
      orderNumber: json['order_number'] as String,
      reference: json['reference'] as String?,
      carrier: json['carrier'] as String?,
      carrierName: json['carrier_name'] as String?,
      shippingMethod: json['shipping_method'] as String?,
      shippingDescription: json['shipping_description'] as String?,
      signatureRequired: json['signature_required'] as bool?,
      returnOrder: json['return_order'] as bool?,
      currency: json['currency'] as String?,
      senderDetails: json['sender_details'] == null
          ? null
          : StarShipItAddress.fromJson(
              json['sender_details'] as Map<String, dynamic>),
      destination: StarShipItAddress.fromJson(
          json['destination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => StarShipItItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) => StarShipItPackage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StarShipItOrderToJson(StarShipItOrder instance) =>
    <String, dynamic>{
      if (instance.orderDate?.toIso8601String() case final value?)
        'order_date': value,
      'order_number': instance.orderNumber,
      if (instance.reference case final value?) 'reference': value,
      if (instance.carrier case final value?) 'carrier': value,
      if (instance.carrierName case final value?) 'carrier_name': value,
      if (instance.shippingMethod case final value?) 'shipping_method': value,
      if (instance.shippingDescription case final value?)
        'shipping_description': value,
      if (instance.signatureRequired case final value?)
        'signature_required': value,
      if (instance.returnOrder case final value?) 'return_order': value,
      if (instance.currency case final value?) 'currency': value,
      if (instance.senderDetails?.toJson() case final value?)
        'sender_details': value,
      'destination': instance.destination.toJson(),
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
      if (instance.packages?.map((e) => e.toJson()).toList() case final value?)
        'packages': value,
    };

StarShipItAddress _$StarShipItAddressFromJson(Map<String, dynamic> json) =>
    StarShipItAddress(
      name: json['name'] as String,
      phone: json['phone'] as String,
      street: json['street'] as String,
      suburb: json['suburb'] as String,
      state: json['state'] as String,
      postCode: json['post_code'] as String,
      country: json['country'] as String,
      deliveryInstructions: json['delivery_instructions'] as String?,
    );

Map<String, dynamic> _$StarShipItAddressToJson(StarShipItAddress instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'street': instance.street,
      'suburb': instance.suburb,
      'state': instance.state,
      'post_code': instance.postCode,
      'country': instance.country,
      if (instance.deliveryInstructions case final value?)
        'delivery_instructions': value,
    };

StarShipItItem _$StarShipItItemFromJson(Map<String, dynamic> json) =>
    StarShipItItem(
      itemId: (json['item_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      sku: json['sku'] as String?,
      tariffCode: json['tariff_code'] as String?,
      countryOfOrigin: json['country_of_origin'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      quantityToShip: (json['quantity_to_ship'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StarShipItItemToJson(StarShipItItem instance) =>
    <String, dynamic>{
      if (instance.itemId case final value?) 'item_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.sku case final value?) 'sku': value,
      if (instance.tariffCode case final value?) 'tariff_code': value,
      if (instance.countryOfOrigin case final value?)
        'country_of_origin': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.quantityToShip case final value?) 'quantity_to_ship': value,
      if (instance.weight case final value?) 'weight': value,
      if (instance.value case final value?) 'value': value,
    };

StarShipItPackage _$StarShipItPackageFromJson(Map<String, dynamic> json) =>
    StarShipItPackage(
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      length: (json['length'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StarShipItPackageToJson(StarShipItPackage instance) =>
    <String, dynamic>{
      if (instance.weight case final value?) 'weight': value,
      if (instance.height case final value?) 'height': value,
      if (instance.width case final value?) 'width': value,
      if (instance.length case final value?) 'length': value,
    };
