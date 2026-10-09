import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  final coupon =
      CouponModel(code: 'TEST', description: '', amount: 20, email: null);
  SaleModel sale() => SaleModel(items: [
        SaleItemModel(
            itemId: 'bottle', description: 'Bottle', price: 20, qty: 1)
      ]);
  test('reservation round trip retains sale identity and integer cents', () {
    final request = PosCheckoutRequest(
        sale: sale(),
        credits: [PosCreditUse(couponId: coupon.id.oid, cents: 1250)]);
    final copy = PosCheckoutRequest.fromJson(request.toJson());
    expect(copy.sale.id, request.sale.id);
    expect(copy.credits.single.cents, 1250);
  });
  test('rejects duplicate, negative and excessive credit', () {
    final credit = PosCreditUse(couponId: coupon.id.oid, cents: 1500);
    expect(() => PosCreditUse(couponId: coupon.id.oid, cents: -1),
        throwsArgumentError);
    expect(() => PosCheckoutRequest(sale: sale(), credits: [credit, credit]),
        throwsArgumentError);
    expect(
        () => PosCheckoutRequest(
            sale: sale(),
            credits: [PosCreditUse(couponId: coupon.id.oid, cents: 2001)]),
        throwsArgumentError);
  });
  test('unknown recovery state fails closed', () {
    expect(
        () => PosCheckoutSnapshot.fromJson(
            {'id': 'x', 'state': 'futureState', 'sale': <String, dynamic>{}}),
        throwsArgumentError);
  });
}
