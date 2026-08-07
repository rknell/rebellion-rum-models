// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCatalogResponseModel _$ProductCatalogResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductCatalogResponseModel(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      syncedAt: jsonToDateTime(json['syncedAt']),
      revision: (json['revision'] as num).toInt(),
    );

Map<String, dynamic> _$ProductCatalogResponseModelToJson(
        ProductCatalogResponseModel instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'syncedAt': dateTimeToJson(instance.syncedAt),
      'revision': instance.revision,
    };

ProductMutationRequestModel _$ProductMutationRequestModelFromJson(
        Map<String, dynamic> json) =>
    ProductMutationRequestModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      expectedRevision: (json['expectedRevision'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductMutationRequestModelToJson(
        ProductMutationRequestModel instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      if (instance.expectedRevision case final value?)
        'expectedRevision': value,
    };

ProductMutationResponseModel _$ProductMutationResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductMutationResponseModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductMutationResponseModelToJson(
        ProductMutationResponseModel instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
    };
