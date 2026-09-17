import 'dart:convert';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  SaleModel basket() => SaleModel(items: [
        SaleItemModel(
            itemId: 'limoncello', description: 'Limoncello', qty: 19, price: 45)
      ], discountTotal: 5);
  test(
      'quote preserves 19 bottles, discount and snapshot through JSON and BSON',
      () {
    final sale = basket();
    final quote = Quote.create(sale,
        customer: 'Customer', now: DateTime.utc(2026, 8, 31));
    sale.items.first.price = 99;
    expect(quote.total, 850);
    expect(quote.validUntil, DateTime.utc(2026, 10, 12));
    expect(quote.deleteAt, DateTime.utc(2027, 2, 28));
    final restored = Quote.fromJson(
        jsonDecode(jsonEncode(quote.toJson())) as Map<String, dynamic>);
    expect(restored.total, 850);
    expect(Quote.fromJson(quote.toDatabase()).id, quote.id);
    expect(restored.toSale().id, quote.saleId);
    expect(restored.toSale().payments, isEmpty);
    expect(restored.toSale().items.single.qty, 19);
    expect(restored.statusAt(quote.validUntil), 'Expired');
  });
  test('rejects empty, paid and invalid baskets', () {
    expect(() => Quote.create(SaleModel(), customer: 'Customer'),
        throwsStateError);
    expect(() => Quote.create(basket(), customer: ''), throwsStateError);
    final sale = basket()
      ..payments.add(PaymentModel(amount: 1, type: PaymentType.cash));
    expect(() => Quote.create(sale, customer: 'Customer'), throwsStateError);
  });
  test('retention clamps leap year month end', () {
    expect(Quote.retentionDate(DateTime.utc(2023, 8, 31)),
        DateTime.utc(2024, 2, 29));
  });
}
