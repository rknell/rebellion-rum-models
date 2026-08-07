import 'package:alcocalc/alcocalc.dart';

/// Converts a legacy container size to litres.
///
/// Product and packaging records historically stored bottle sizes as either
/// millilitres (`700`) or litres (`0.7`). Values above 10 are treated as mL.
double containerSizeLitres(double value) {
  if (!value.isFinite || value <= 0) return 0;
  return value > 10 ? value / 1000 : value;
}

/// Converts an alcohol strength to its canonical fractional representation.
///
/// Canonical records use `0.40` for 40%, while a small number of legacy rows
/// use `40`. Values above 1 are therefore interpreted as percentages.
double abvFraction(double value) {
  if (!value.isFinite || value <= 0) return 0;
  return value > 1 ? value / 100 : value;
}

double litresOfAlcohol({
  required double containerSize,
  required double abv,
  required num quantity,
}) {
  if (quantity <= 0) return 0;
  return Alcocalc.packagedLitresOfAlcohol(
    containerSizeLitres: containerSizeLitres(containerSize),
    abv: abvFraction(abv),
    quantity: quantity,
  );
}
