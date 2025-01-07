import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String id;
  final String barcode;
  final String description;
  final double price;
  final int stock;
  final String category;
  final bool isAvailableOnline;
  final String? name;
  final List<String> images;
  final String? longDescription;
  final String? shortDescription;
  final int? volume;
  final double? weight;
  final double? abv;
  final String? shortcut;
  final bool? enabled;

  const Product({
    required this.id,
    required this.barcode,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    this.isAvailableOnline = false,
    this.name,
    this.images = const [],
    this.longDescription,
    this.shortDescription,
    this.volume,
    this.weight,
    this.abv,
    this.shortcut,
    this.enabled,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
