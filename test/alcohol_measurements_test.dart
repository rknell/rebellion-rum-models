import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('LAL calculation supports millilitre and legacy litre container sizes',
      () {
    expect(
      litresOfAlcohol(containerSize: 700, abv: 0.4, quantity: 6),
      closeTo(1.68, 0.000001),
    );
    expect(
      litresOfAlcohol(containerSize: 0.7, abv: 40, quantity: 6),
      closeTo(1.68, 0.000001),
    );
  });
}
