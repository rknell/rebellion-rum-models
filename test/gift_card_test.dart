import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('gift card round trips and never needs alcohol data', () {
    final item = SaleItemModel(
        description: 'Gift Card',
        price: 50,
        itemId: 'gift-card:one',
        qty: 1,
        kind: SaleItemKind.giftCard,
        giftCard: GiftCardDetails(
            valueCents: 5000, recipientName: 'Jo', email: 'jo@example.com'));
    final restored = SaleItemModel.fromJson(item.toJson());
    expect(restored.isGiftCard, isTrue);
    expect(restored.giftCard!.recipientName, 'Jo');
    expect(restored.isMissingAlcoholSnapshot, isFalse);
  });
  test('legacy lines remain products', () {
    expect(
        SaleItemModel.fromJson(
                {'description': 'Rum', 'price': 50, 'itemId': 'rum', 'qty': 1})
            .kind,
        SaleItemKind.product);
  });
  test('gift issuance is charged but excluded from revenue', () {
    final sale = SaleModel(items: [
      SaleItemModel(description: 'Rum', price: 60, itemId: 'rum', qty: 1),
      SaleItemModel(
          description: 'Gift Card',
          price: 50,
          itemId: 'gift-card:one',
          qty: 1,
          kind: SaleItemKind.giftCard,
          giftCard: GiftCardDetails(valueCents: 5000)),
    ], discountTotal: 10);
    expect(sale.giftCardsIssuedCents, 5000);
    expect(sale.salesRevenueCents, 5000);
    expect(sale.chargeTotalCents, 10000);
    expect(() => sale.validateGiftCardSale(), returnsNormally);
    sale.items.last.qty = 2;
    expect(() => sale.validateGiftCardSale(), throwsArgumentError);
  });
  test('gift value cannot be discounted or funded by coupons', () {
    final sale = SaleModel(items: [
      SaleItemModel(
          description: 'Gift Card',
          price: 50,
          itemId: 'gift-card:one',
          qty: 1,
          kind: SaleItemKind.giftCard,
          giftCard: GiftCardDetails(valueCents: 5000))
    ], discountTotal: 1);
    expect(() => sale.validateGiftCardSale(), throwsArgumentError);
    sale.discountTotal = 0;
    sale.payments = [PaymentModel(amount: 50, type: PaymentType.coupon)];
    expect(() => sale.validateGiftCardSale(), throwsArgumentError);
  });
}
