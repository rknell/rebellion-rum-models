import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('ProductModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _\$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      category: \$enumDecodeNullable(_\$ProductCategoryEnumMap, json['category'],
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

Map<String, dynamic> _\$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'name': instance.name,
      'price': instance.price,
      'matesRatesPrice': instance.matesRatesPrice,
      'stock': instance.stock,
      if (_\$ProductCategoryEnumMap[instance.category] case final value?)
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

const _\$ProductCategoryEnumMap = {
  ProductCategory.vodka: 'vodka',
  ProductCategory.gin: 'gin',
  ProductCategory.rum: 'rum',
  ProductCategory.softdrink: 'softdrink',
  ProductCategory.merch: 'merch',
  ProductCategory.other: 'other',
};

ProductRecipe _\$ProductRecipeFromJson(Map<String, dynamic> json) =>
    ProductRecipe(
      targetAbv: (json['targetAbv'] as num).toDouble(),
      sugars: (json['sugars'] as List<dynamic>?)
              ?.map((e) => SugarInputModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _\$ProductRecipeToJson(ProductRecipe instance) =>
    <String, dynamic>{
      'targetAbv': instance.targetAbv,
      'sugars': instance.sugars.map((e) => e.toJson()).toList(),
    };
''';

    test(
        'should contain fromJson function with all required fields for ProductModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);

      expect(
        result.contains('export interface ProductModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the ProductModel interface',
      );

      // Verify that all fields from the model are present in the interface with correct types
      expect(result.contains('_id: string'), isTrue);
      expect(result.contains('barcode: string'), isTrue);
      expect(result.contains('name: string | null'), isTrue);
      expect(result.contains('price: number'), isTrue);
      expect(result.contains('stock: number | null'), isTrue);
      expect(result.contains('category: ProductCategory'), isTrue);
      expect(result.contains('volume: number | null'), isTrue);
      expect(result.contains('abv: number | null'), isTrue);
      expect(result.contains('percentAustralian: number | null'), isTrue);
      expect(result.contains('productType: string | null'), isTrue);
      expect(result.contains('isAvailableOnline: boolean | null'), isTrue);
      expect(result.contains('images: string[] | null'), isTrue);
      expect(result.contains('longDescription: string | null'), isTrue);
      expect(result.contains('shortDescription: string | null'), isTrue);
      expect(result.contains('weight: number | null'), isTrue);
      expect(result.contains('slug: string | null'), isTrue);
      expect(result.contains('image: string | null'), isTrue);
      expect(result.contains('enabled: boolean | null'), isTrue);
      expect(result.contains('matesRatesPrice: number | null'), isTrue);
      expect(result.contains('isArchived: boolean | null'), isTrue);
      expect(result.contains('recipe: ProductRecipe | null'), isTrue);
    });

    test('should contain ProductCategory enum in the generated TypeScript',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);

      expect(
        result.contains('export enum ProductCategory'),
        isTrue,
        reason: 'Generated TypeScript should contain the ProductCategory enum',
      );

      // Verify enum values
      expect(result.contains('vodka = "vodka"'), isTrue);
      expect(result.contains('gin = "gin"'), isTrue);
      expect(result.contains('rum = "rum"'), isTrue);
      expect(result.contains('softdrink = "softdrink"'), isTrue);
      expect(result.contains('merch = "merch"'), isTrue);
      expect(result.contains('other = "other"'), isTrue);
    });

    test(
        'should contain fromJson function with all required fields for ProductRecipe',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);

      expect(
        result.contains('export interface ProductRecipe'),
        isTrue,
        reason:
            'Generated TypeScript should contain the ProductRecipe interface',
      );

      // Verify that all fields from ProductRecipe are present in the interface
      expect(result.contains('targetAbv: number'), isTrue);
      expect(result.contains('sugars: SugarInputModel[] | null'), isTrue);
    });
  });
}
