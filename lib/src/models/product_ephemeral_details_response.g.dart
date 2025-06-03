// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_ephemeral_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductEphemeralDetails _$ProductEphemeralDetailsFromJson(
        Map<String, dynamic> json) =>
    ProductEphemeralDetails(
      barcode: json['barcode'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
    );

Map<String, dynamic> _$ProductEphemeralDetailsToJson(
        ProductEphemeralDetails instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'price': instance.price,
      'stock': instance.stock,
    };

ProductEphemeralDetailsResponse _$ProductEphemeralDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ProductEphemeralDetailsResponse(
      success: json['success'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              ProductEphemeralDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$ProductEphemeralDetailsResponseToJson(
        ProductEphemeralDetailsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
