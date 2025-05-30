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
      enabled: json['enabled'] as bool?,
      matesRatesPrice: (json['matesRatesPrice'] as num?)?.toDouble(),
      isArchived: json['isArchived'] as bool? ?? false,
      recipe: json['recipe'] == null
          ? null
          : ProductRecipe.fromJson(json['recipe'] as Map<String, dynamic>),
    )
      ..slug = json['slug'] as String?
      ..image = json['image'] as String?;

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
      if (instance.enabled case final value?) 'enabled': value,
      'isArchived': instance.isArchived,
      if (instance.recipe?.toJson() case final value?) 'recipe': value,
      if (instance.slug case final value?) 'slug': value,
      if (instance.image case final value?) 'image': value,
    };

const _$ProductCategoryEnumMap = {
  ProductCategory.vodka: 'vodka',
  ProductCategory.gin: 'gin',
  ProductCategory.rum: 'rum',
  ProductCategory.softdrink: 'softdrink',
  ProductCategory.merch: 'merch',
  ProductCategory.other: 'other',
};

ProductRecipe _$ProductRecipeFromJson(Map<String, dynamic> json) =>
    ProductRecipe(
      targetAbv: (json['targetAbv'] as num).toDouble(),
      sugars: (json['sugars'] as List<dynamic>?)
              ?.map((e) => SugarInputModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductRecipeToJson(ProductRecipe instance) =>
    <String, dynamic>{
      'targetAbv': instance.targetAbv,
      'sugars': instance.sugars.map((e) => e.toJson()).toList(),
    };
