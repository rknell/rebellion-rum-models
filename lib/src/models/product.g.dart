// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      barcode: json['barcode'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      category: json['category'] as String,
      isAvailableOnline: json['isAvailableOnline'] as bool,
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      longDescription: json['longDescription'] as String,
      shortDescription: json['shortDescription'] as String,
      volume: (json['volume'] as num).toInt(),
      weight: (json['weight'] as num).toDouble(),
      abv: (json['abv'] as num).toDouble(),
      shortcut: json['shortcut'] as String,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'category': instance.category,
      'isAvailableOnline': instance.isAvailableOnline,
      'name': instance.name,
      'images': instance.images,
      'longDescription': instance.longDescription,
      'shortDescription': instance.shortDescription,
      'volume': instance.volume,
      'weight': instance.weight,
      'abv': instance.abv,
      'shortcut': instance.shortcut,
    };
