import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('GinStillStocktakeModel', () {
    test('calculates LALs from the full liquid mass', () {
      final stocktake = GinStillStocktakeModel(
        height: 28,
        abv: 0.20,
        temperature: 20,
      );

      expect(stocktake.volume, closeTo(126.9988, 0.001));
      expect(stocktake.lals.lals, closeTo(25.3998, 0.001));
      expect(stocktake.lals.weight, closeTo(123.6406, 0.001));
    });

    test('10 cm headspace is the calibrated maximum fill volume', () {
      expect(
        GinStillStocktakeModel.currentVolume(10),
        closeTo(196.2704, 0.001),
      );
    });
  });
}
