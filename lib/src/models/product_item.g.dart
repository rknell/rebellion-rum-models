// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      barcode: json['barcode'] as String,
      price: (json['price'] as num).toDouble(),
      productType: json['productType'] as String,
      volume: (json['volume'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      percentAustralian: (json['percentAustralian'] as num).toDouble(),
      description: json['description'] as String?,
      longDescription: json['longDescription'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'barcode': instance.barcode,
      'price': instance.price,
      'productType': instance.productType,
      'volume': instance.volume,
      'abv': instance.abv,
      'percentAustralian': instance.percentAustralian,
      if (instance.description case final value?) 'description': value,
      if (instance.longDescription case final value?) 'longDescription': value,
      if (instance.images case final value?) 'images': value,
    };
