// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      category: $enumDecodeNullable(_$ProductCategoryEnumMap, json['category'],
          unknownValue: ProductCategory.other),
      volume: (json['volume'] as num?)?.toDouble(),
      abv: (json['abv'] as num?)?.toDouble(),
      percentAustralian: (json['percentAustralian'] as num?)?.toDouble(),
      productType: json['productType'] as String?,
      isAvailableOnline: json['isAvailableOnline'] as bool? ?? false,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      longDescription: json['longDescription'] as String?,
      shortDescription: json['shortDescription'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      shortcut: json['shortcut'] as String?,
      enabled: json['enabled'] as bool?,
      matesRatesPrice: (json['matesRatesPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'name': instance.name,
      'price': instance.price,
      'matesRatesPrice': instance.matesRatesPrice,
      'stock': instance.stock,
      if (_$ProductCategoryEnumMap[instance.category] case final value?)
        'category': value,
      if (instance.productType case final value?) 'productType': value,
      'isAvailableOnline': instance.isAvailableOnline,
      'images': instance.images,
      if (instance.longDescription case final value?) 'longDescription': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      'volume': instance.volume,
      if (instance.weight case final value?) 'weight': value,
      'abv': instance.abv,
      'percentAustralian': instance.percentAustralian,
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

// **************************************************************************
// ObjectIdFieldsGenerator
// **************************************************************************

// Generated objectIdFields getter for ProductModel
extension ProductModelObjectIdFields on ProductModel {
  @override
  Set<String> get objectIdFields => {
        '_id',
      };
}
