import 'package:json_annotation/json_annotation.dart';

part 'sale_item.g.dart';

@JsonSerializable()
class SaleItem {
  final String description;
  final double price;
  final String itemId;
  final int qty;

  const SaleItem({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
  });

  factory SaleItem.fromJson(Map<String, dynamic> json) =>
      _$SaleItemFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemToJson(this);
}
