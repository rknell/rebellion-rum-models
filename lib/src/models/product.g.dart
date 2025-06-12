// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Award _$AwardFromJson(Map<String, dynamic> json) => Award(
      id: (json['id'] as num).toInt(),
      level: json['level'] as String,
      competition: json['competition'] as String,
      year: (json['year'] as num).toInt(),
    );

Map<String, dynamic> _$AwardToJson(Award instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'competition': instance.competition,
      'year': instance.year,
    };

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
      weight: (json['weight'] as num?)?.toDouble(),
      enabled: json['enabled'] as bool?,
      matesRatesPrice: (json['matesRatesPrice'] as num?)?.toDouble(),
      isArchived: json['isArchived'] as bool? ?? false,
      recipe: json['recipe'] == null
          ? null
          : ProductRecipe.fromJson(json['recipe'] as Map<String, dynamic>),
      isFeatured: json['isFeatured'] as bool?,
      heroImage: json['heroImage'] as String?,
      heroDescription: json['heroDescription'] as String?,
      bottleImage: json['bottleImage'] as String?,
      story1Image: json['story1Image'] as String?,
      story2Image: json['story2Image'] as String?,
      awards: (json['awards'] as List<dynamic>?)
              ?.map((e) => Award.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      story1: json['story1'] as String?,
      story2: json['story2'] as String?,
      botanicals: (json['botanicals'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      recipeSlugs: (json['recipeSlugs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      headerAlignment: json['headerAlignment'] as String?,
    )
      ..slug = json['slug'] as String?
      ..shortcut = json['shortcut'] as String?;

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
      'volume': instance.volume,
      if (instance.weight case final value?) 'weight': value,
      'abv': instance.abv,
      'percentAustralian': instance.percentAustralian,
      if (instance.enabled case final value?) 'enabled': value,
      'isArchived': instance.isArchived,
      if (instance.recipe?.toJson() case final value?) 'recipe': value,
      if (instance.slug case final value?) 'slug': value,
      if (instance.isFeatured case final value?) 'isFeatured': value,
      if (instance.heroImage case final value?) 'heroImage': value,
      if (instance.heroDescription case final value?) 'heroDescription': value,
      if (instance.bottleImage case final value?) 'bottleImage': value,
      if (instance.story1Image case final value?) 'story1Image': value,
      if (instance.story2Image case final value?) 'story2Image': value,
      'awards': instance.awards.map((e) => e.toJson()).toList(),
      if (instance.story1 case final value?) 'story1': value,
      if (instance.story2 case final value?) 'story2': value,
      'botanicals': instance.botanicals,
      'recipeSlugs': instance.recipeSlugs,
      if (instance.headerAlignment case final value?) 'headerAlignment': value,
      if (instance.shortcut case final value?) 'shortcut': value,
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
