// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String,
      barcode: json['barcode'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      category: $enumDecode(_$ProductCategoryEnumMap, json['category']),
      isAvailableOnline: json['isAvailableOnline'] as bool? ?? false,
      name: json['name'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      longDescription: json['longDescription'] as String?,
      shortDescription: json['shortDescription'] as String?,
      volume: (json['volume'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      abv: (json['abv'] as num?)?.toDouble(),
      shortcut: json['shortcut'] as String?,
      enabled: json['enabled'] as bool?,
      matesRatesPrice: (json['matesRatesPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      'description': instance.description,
      'price': instance.price,
      'matesRatesPrice': instance.matesRatesPrice,
      'stock': instance.stock,
      'category': _$ProductCategoryEnumMap[instance.category]!,
      'isAvailableOnline': instance.isAvailableOnline,
      if (instance.name case final value?) 'name': value,
      'images': instance.images,
      if (instance.longDescription case final value?) 'longDescription': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.volume case final value?) 'volume': value,
      if (instance.weight case final value?) 'weight': value,
      if (instance.abv case final value?) 'abv': value,
      if (instance.shortcut case final value?) 'shortcut': value,
      if (instance.enabled case final value?) 'enabled': value,
    };

const _$ProductCategoryEnumMap = {
  ProductCategory.vodka: 'vodka',
  ProductCategory.gin: 'gin',
  ProductCategory.rum: 'rum',
  ProductCategory.softdrink: 'softdrink',
  ProductCategory.merch: 'merch',
  ProductCategory.other: 'other',
};
