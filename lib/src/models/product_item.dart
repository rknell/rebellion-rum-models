import 'package:json_annotation/json_annotation.dart';

part 'product_item.g.dart';

@JsonSerializable()
class ProductItem {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String barcode;
  final double price;
  final String productType;
  final double volume;
  final double abv;
  final double percentAustralian;
  final String? description;
  final String? longDescription;
  final List<String>? images;

  const ProductItem({
    required this.id,
    required this.name,
    required this.barcode,
    required this.price,
    required this.productType,
    required this.volume,
    required this.abv,
    required this.percentAustralian,
    this.description,
    this.longDescription,
    this.images,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
