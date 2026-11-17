import 'package:json_annotation/json_annotation.dart';

import 'package:rebellion_rum_models/src/json_helpers.dart';
import 'package:rebellion_rum_models/src/models/product.dart';

import 'package:rebellion_rum_models/src/models/pos_shortcuts.dart';

part 'product_catalog.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductCatalogResponseModel {
  ProductCatalogResponseModel({
    required this.products,
    required this.syncedAt,
    required this.revision,
    this.posShortcuts,
  });

  final List<ProductModel> products;

  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  final DateTime syncedAt;

  final int revision;
  final PosShortcutConfiguration? posShortcuts;

  factory ProductCatalogResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCatalogResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCatalogResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductMutationRequestModel {
  ProductMutationRequestModel({
    required this.product,
    this.expectedRevision,
  });

  final ProductModel product;
  final int? expectedRevision;

  factory ProductMutationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMutationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMutationRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductMutationResponseModel {
  ProductMutationResponseModel({required this.product});

  final ProductModel product;

  factory ProductMutationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMutationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMutationResponseModelToJson(this);
}
