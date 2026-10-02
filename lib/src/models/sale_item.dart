import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/excise_reporting.dart';
import 'package:rebellion_rum_models/src/models/product.dart';

import 'package:rebellion_rum_models/src/models/gift_card.dart';

part 'sale_item.g.dart';

enum SaleItemKind { product, giftCard }

/// Represents an individual item line in a sale.
///
/// Each SaleItemModel captures the essential information about a product
/// that was sold, including its description, price, and quantity.
///
/// Example:
/// ```dart
/// final item = SaleItemModel(
///   description: 'Premium Dark Rum 750ml',
///   price: 49.99,
///   itemId: 'PROD-001',
///   qty: 2,
/// );
/// ```
@JsonSerializable()
class SaleItemModel {
  /// Product description as shown on receipt
  String description;

  @JsonKey(defaultValue: SaleItemKind.product)
  SaleItemKind kind;
  GiftCardDetails? giftCard;

  bool get isGiftCard => kind == SaleItemKind.giftCard;

  /// Unit price at time of sale
  double price;

  /// Reference to the product ID
  String itemId;

  /// Quantity sold
  int qty;

  /// Captured product classification. Null means a legacy or unknown line;
  /// false positively identifies a non-alcoholic product.
  bool? isAlcohol;

  /// Product volume in millilitres at the time of sale.
  double? unitVolumeMl;

  /// Product ABV at the time of sale, stored as a decimal (0.37 for 37%).
  double? unitAbv;

  /// Litres of absolute alcohol for one unit at the time of sale.
  double? lalPerUnit;

  /// Total litres of absolute alcohol for this sale line.
  double? totalLals;

  SaleItemModel({
    required this.description,
    required this.price,
    required this.itemId,
    required this.qty,
    this.kind = SaleItemKind.product,
    this.giftCard,
    this.isAlcohol,
    this.unitVolumeMl,
    this.unitAbv,
    this.lalPerUnit,
    this.totalLals,
  });

  /// Shared checkout snapshot for POS and website sales, including returns.
  factory SaleItemModel.fromProduct({
    required ProductModel product,
    required double price,
    required int qty,
  }) {
    final alcohol = product.isAlcoholProduct;
    final snapshot = alcohol == true
        ? alcoholSnapshotForSaleLine(
            volumeMl: product.volume, abv: product.abv, quantity: qty)
        : null;
    if (alcohol == true && snapshot == null) {
      throw ArgumentError(
          'Alcohol product "${product.name}" needs valid ABV, volume and quantity before it can be sold or returned.');
    }
    return SaleItemModel(
      description: product.name,
      price: price,
      itemId: product.barcode,
      qty: qty,
      isAlcohol: alcohol,
      unitVolumeMl: snapshot?.unitVolumeMl,
      unitAbv: snapshot?.unitAbv,
      lalPerUnit: snapshot?.lalPerUnit,
      totalLals: snapshot?.totalLals,
    );
  }

  bool get isMissingAlcoholSnapshot =>
      !isGiftCard &&
      !hasAlcoholSnapshot &&
      isAlcohol != false &&
      qty > 0 &&
      price > 0 &&
      itemId != 'shipping' &&
      !itemId.startsWith('custom-sale-item:');

  Map<String, dynamic> toCommerceLedgerJson() => {
        ...toJson(),
        'unitPriceCents': (price * 100).round(),
        'totalCents': (price * qty * 100).round(),
      };

  bool get hasAlcoholSnapshot =>
      (unitVolumeMl ?? 0) > 0 &&
      (unitAbv ?? 0) > 0 &&
      (lalPerUnit ?? 0) > 0 &&
      qty != 0 &&
      (totalLals ?? 0) != 0;

  void refreshAlcoholTotals() {
    final perUnit = lalPerUnit;
    if (perUnit == null || perUnit <= 0) {
      totalLals = null;
      return;
    }
    totalLals = perUnit * qty;
  }

  factory SaleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SaleItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleItemModelToJson(this);

  // No need to override objectIdFields since this model has no ObjectId fields
}
