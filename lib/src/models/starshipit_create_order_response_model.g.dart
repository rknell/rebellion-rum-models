// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starshipit_create_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarShipItCreateOrderResponse _$StarShipItCreateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    StarShipItCreateOrderResponse(
      order: StarShipItOrderResponse.fromJson(
          json['order'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? true,
    );

Map<String, dynamic> _$StarShipItCreateOrderResponseToJson(
        StarShipItCreateOrderResponse instance) =>
    <String, dynamic>{
      'order': instance.order.toJson(),
      'success': instance.success,
    };

StarShipItOrderResponse _$StarShipItOrderResponseFromJson(
        Map<String, dynamic> json) =>
    StarShipItOrderResponse(
      orderId: (json['order_id'] as num).toInt(),
      orderDate: DateTime.parse(json['order_date'] as String),
      orderNumber: json['order_number'] as String,
      reference: json['reference'] as String?,
      carrier: StarShipItOrderResponse._carrierFromJson(json['carrier']),
      carrierName: json['carrier_name'] as String?,
      carrierServiceCode: json['carrier_service_code'] as String?,
      shippingMethod: json['shipping_method'] as String?,
      signatureRequired: json['signature_required'] as bool?,
      dangerousGoods: json['dangerous_goods'] as bool?,
      destination: StarShipItAddressResponse.fromJson(
          json['destination'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => StarShipItItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      packages: (json['packages'] as List<dynamic>?)
          ?.map((e) =>
              StarShipItPackageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      declaredValue: (json['declared_value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StarShipItOrderResponseToJson(
        StarShipItOrderResponse instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'order_date': instance.orderDate.toIso8601String(),
      'order_number': instance.orderNumber,
      if (instance.reference case final value?) 'reference': value,
      if (StarShipItOrderResponse._carrierToJson(instance.carrier)
          case final value?)
        'carrier': value,
      if (instance.carrierName case final value?) 'carrier_name': value,
      if (instance.carrierServiceCode case final value?)
        'carrier_service_code': value,
      if (instance.shippingMethod case final value?) 'shipping_method': value,
      if (instance.signatureRequired case final value?)
        'signature_required': value,
      if (instance.dangerousGoods case final value?) 'dangerous_goods': value,
      'destination': instance.destination.toJson(),
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'items': value,
      if (instance.packages?.map((e) => e.toJson()).toList() case final value?)
        'packages': value,
      if (instance.declaredValue case final value?) 'declared_value': value,
    };

StarShipItAddressResponse _$StarShipItAddressResponseFromJson(
        Map<String, dynamic> json) =>
    StarShipItAddressResponse(
      name: json['name'] as String,
      phone: json['phone'] as String,
      street: json['street'] as String,
      suburb: json['suburb'] as String,
      state: json['state'] as String,
      postCode: json['post_code'] as String,
      country: json['country'] as String,
      deliveryInstructions: json['delivery_instructions'] as String?,
    );

Map<String, dynamic> _$StarShipItAddressResponseToJson(
        StarShipItAddressResponse instance) =>
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

StarShipItItemResponse _$StarShipItItemResponseFromJson(
        Map<String, dynamic> json) =>
    StarShipItItemResponse(
      itemId: (json['item_id'] as num).toInt(),
      description: json['description'] as String,
      sku: json['sku'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      quantityToShip: (json['quantity_to_ship'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$StarShipItItemResponseToJson(
        StarShipItItemResponse instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'description': instance.description,
      'sku': instance.sku,
      'quantity': instance.quantity,
      'quantity_to_ship': instance.quantityToShip,
      'weight': instance.weight,
      'value': instance.value,
    };

StarShipItPackageResponse _$StarShipItPackageResponseFromJson(
        Map<String, dynamic> json) =>
    StarShipItPackageResponse(
      packageId: (json['package_id'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
    );

Map<String, dynamic> _$StarShipItPackageResponseToJson(
        StarShipItPackageResponse instance) =>
    <String, dynamic>{
      'package_id': instance.packageId,
      'weight': instance.weight,
      'height': instance.height,
      'width': instance.width,
      'length': instance.length,
    };
