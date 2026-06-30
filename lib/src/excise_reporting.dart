class AlcoholSnapshot {
  final double unitVolumeMl;
  final double unitAbv;
  final double lalPerUnit;
  final double totalLals;

  const AlcoholSnapshot({
    required this.unitVolumeMl,
    required this.unitAbv,
    required this.lalPerUnit,
    required this.totalLals,
  });
}

class ExciseRate {
  final DateTime effectiveFrom;
  final double ratePerLal;
  final String description;

  const ExciseRate({
    required this.effectiveFrom,
    required this.ratePerLal,
    required this.description,
  });
}

class RemissionPace {
  final DateTime start;
  final DateTime end;
  final double capAud;
  final double allocatedRemissionAud;
  final double allocatedLals;
  final double averageRatePerLal;

  const RemissionPace({
    required this.start,
    required this.end,
    required this.capAud,
    required this.allocatedRemissionAud,
    required this.allocatedLals,
    required this.averageRatePerLal,
  });
}

final List<ExciseRate> defaultAlcoholExciseRates = [
  ExciseRate(
    effectiveFrom: DateTime.utc(2026, 2, 2),
    ratePerLal: 107.99,
    description: 'ATO spirits/OEB >10% rate from 2 Feb 2026',
  ),
];

bool hasValidAlcoholFields({
  required double volumeMl,
  required double abv,
}) {
  return volumeMl > 0 && abv > 0;
}

AlcoholSnapshot? alcoholSnapshotForSaleLine({
  required double volumeMl,
  required double abv,
  required int quantity,
}) {
  if (!hasValidAlcoholFields(volumeMl: volumeMl, abv: abv) || quantity <= 0) {
    return null;
  }
  final lalPerUnit = volumeMl / 1000 * abv;
  return AlcoholSnapshot(
    unitVolumeMl: volumeMl,
    unitAbv: abv,
    lalPerUnit: lalPerUnit,
    totalLals: lalPerUnit * quantity,
  );
}

DateTime australianFinancialYearStart(DateTime date) {
  return date.month >= DateTime.july
      ? DateTime(date.year, DateTime.july, 1)
      : DateTime(date.year - 1, DateTime.july, 1);
}

DateTime australianFinancialYearEndExclusive(DateTime date) {
  final start = australianFinancialYearStart(date);
  return DateTime(start.year + 1, DateTime.july, 1);
}

double remissionCapAudForFinancialYear(DateTime date) {
  final start = australianFinancialYearStart(date);
  if (!start.isBefore(DateTime(2026, DateTime.july, 1))) {
    return 400000;
  }
  return 350000;
}

ExciseRate exciseRateForDate(
  DateTime date, {
  List<ExciseRate>? rates,
}) {
  final sorted = List<ExciseRate>.from(rates ?? defaultAlcoholExciseRates)
    ..sort((a, b) => a.effectiveFrom.compareTo(b.effectiveFrom));
  if (sorted.isEmpty) {
    throw ArgumentError('At least one excise rate is required.');
  }

  var selected = sorted.first;
  for (final rate in sorted) {
    if (rate.effectiveFrom.isAfter(date)) break;
    selected = rate;
  }
  return selected;
}

double exciseValueAud({
  required double lals,
  required DateTime date,
  List<ExciseRate>? rates,
}) {
  return lals * exciseRateForDate(date, rates: rates).ratePerLal;
}

RemissionPace remissionPaceForPeriod({
  required DateTime start,
  required DateTime end,
  List<ExciseRate>? rates,
}) {
  if (!end.isAfter(start)) {
    return RemissionPace(
      start: start,
      end: end,
      capAud: remissionCapAudForFinancialYear(start),
      allocatedRemissionAud: 0,
      allocatedLals: 0,
      averageRatePerLal: exciseRateForDate(start, rates: rates).ratePerLal,
    );
  }

  final fyStart = australianFinancialYearStart(start);
  final fyEnd = australianFinancialYearEndExclusive(start);
  final boundedStart = start.isBefore(fyStart) ? fyStart : start;
  final boundedEnd = end.isAfter(fyEnd) ? fyEnd : end;
  if (!boundedEnd.isAfter(boundedStart)) {
    return RemissionPace(
      start: boundedStart,
      end: boundedEnd,
      capAud: remissionCapAudForFinancialYear(start),
      allocatedRemissionAud: 0,
      allocatedLals: 0,
      averageRatePerLal: exciseRateForDate(start, rates: rates).ratePerLal,
    );
  }

  final fyDays = fyEnd.difference(fyStart).inDays;
  final days = boundedEnd.difference(boundedStart).inDays;
  final capAud = remissionCapAudForFinancialYear(start);
  final allocatedAud = capAud * days / fyDays;
  final rate = exciseRateForDate(boundedStart, rates: rates).ratePerLal;
  return RemissionPace(
    start: boundedStart,
    end: boundedEnd,
    capAud: capAud,
    allocatedRemissionAud: allocatedAud,
    allocatedLals: allocatedAud / rate,
    averageRatePerLal: rate,
  );
}
