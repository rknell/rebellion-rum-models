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
    expect(restored.statusAt(quote.validUntil), 'Review prices');
  });
  test(
      'revision, account and invoice references round trip with legacy defaults',
      () {
    final original = Quote.create(basket(), customer: 'Buyer');
    expect(original.revision, 0);
    final json = {
      ...original.toJson(),
      'revision': 3,
      'accountId': 'account-1',
      'wholesaleInvoiceId': 'invoice-1'
    };
    final restored = Quote.fromJson(json);
    expect(restored.revision, 3);
    expect(restored.accountId, 'account-1');
    expect(restored.wholesaleInvoiceId, 'invoice-1');
    expect(Quote.fromJson(restored.toDatabase()).revision, 3);
    expect(restored.toSale().metadata['sourceQuoteId'], restored.id.oid);
    for (final invalid in [-1, 1.5, '2']) {
      expect(() => Quote.fromJson({...json, 'revision': invalid}),
          throwsFormatException);
    }
    for (final key in ['accountId', 'wholesaleInvoiceId']) {
      expect(() => Quote.fromJson({...json, key: 7}), throwsFormatException);
      expect(Quote.fromJson({...json, key: null}).toJson()[key], isNull);
    }
    expect(Quote.fromJson({...json, 'revision': null}).revision, 0);
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
  test(
      'short quote numbers survive transport and old references remain available',
      () {
    final original = Quote.create(basket(), customer: 'Customer');
    final numbered =
        Quote.fromJson({...original.toJson(), 'quoteNumber': 'Q-10001'});
    expect(numbered.number, 'Q-10001');
    expect(numbered.legacyNumber, original.number);
    expect(Quote.fromJson(numbered.toDatabase()).number, 'Q-10001');
  });
}
