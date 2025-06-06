// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CocktailRecipeModel _$CocktailRecipeModelFromJson(Map<String, dynamic> json) =>
    CocktailRecipeModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      name: json['name'] as String,
      description: json['description'] as String,
      slug: json['slug'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      glass: json['glass'] as String,
      image: json['image'] as String?,
      imageThumbnail: json['imageThumbnail'] as String?,
      garnish: json['garnish'] as String?,
      llmDescription: json['llmDescription'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      featuredProductIds: (json['featuredProductIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CocktailRecipeModelToJson(
        CocktailRecipeModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'description': instance.description,
      if (instance.image case final value?) 'image': value,
      if (instance.imageThumbnail case final value?) 'imageThumbnail': value,
      'slug': instance.slug,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      if (instance.garnish case final value?) 'garnish': value,
      'glass': instance.glass,
      if (instance.llmDescription case final value?) 'llmDescription': value,
      'isFeatured': instance.isFeatured,
      'isActive': instance.isActive,
      'featuredProductIds': instance.featuredProductIds,
      if (instance.createdAt?.toIso8601String() case final value?)
        'createdAt': value,
      if (instance.updatedAt?.toIso8601String() case final value?)
        'updatedAt': value,
    };
