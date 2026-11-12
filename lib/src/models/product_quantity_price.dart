/// A POS unit price applied to every unit once the minimum quantity is met.
/// Website and wholesale pricing are deliberately independent.
class ProductQuantityPrice {
  final int minimumQuantity;
  final double unitPrice;

  ProductQuantityPrice(
      {required this.minimumQuantity, required this.unitPrice}) {
    if (minimumQuantity < 2) {
      throw ArgumentError.value(
          minimumQuantity, 'minimumQuantity', 'Must be at least 2');
    }
    if (!unitPrice.isFinite || unitPrice < 0) {
      throw ArgumentError.value(
          unitPrice, 'unitPrice', 'Must be finite and non-negative');
    }
  }

  factory ProductQuantityPrice.fromJson(Map<String, dynamic> json) {
    final quantity = json['minimumQuantity'];
    final price = json['unitPrice'];
    if (quantity is! int || quantity < 2) {
      throw FormatException(
          'posQuantityPrices.minimumQuantity must be an integer of at least 2');
    }
    if (price is! num || !price.isFinite || price < 0) {
      throw FormatException(
          'posQuantityPrices.unitPrice must be finite and non-negative');
    }
    return ProductQuantityPrice(
        minimumQuantity: quantity, unitPrice: price.toDouble());
  }

  Map<String, dynamic> toJson() => {
        'minimumQuantity': minimumQuantity,
        'unitPrice': unitPrice,
      };
}
