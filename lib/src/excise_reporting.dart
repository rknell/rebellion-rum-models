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

class RemissionPaceSegment {
  final DateTime start;
  final DateTime end;
  final DateTime financialYearStart;
  final double capAud;
  final double ratePerLal;
  final double allocatedRemissionAud;
  final double allocatedLals;

  const RemissionPaceSegment({
    required this.start,
    required this.end,
    required this.financialYearStart,
    required this.capAud,
    required this.ratePerLal,
    required this.allocatedRemissionAud,
    required this.allocatedLals,
  });
}

class RemissionPace {
  final DateTime start;
  final DateTime end;
  final double capAud;
  final double allocatedRemissionAud;
  final double allocatedLals;
  final double averageRatePerLal;
  final List<RemissionPaceSegment> segments;

  const RemissionPace({
    required this.start,
    required this.end,
    required this.capAud,
    required this.allocatedRemissionAud,
    required this.allocatedLals,
    required this.averageRatePerLal,
    this.segments = const [],
  });
}

final List<ExciseRate> defaultAlcoholExciseRates = [
  ExciseRate(
    effectiveFrom: DateTime.utc(2024, 2, 5),
    ratePerLal: 101.85,
    description: 'ATO spirits/OEB rate from 5 Feb 2024',
  ),
  ExciseRate(
    effectiveFrom: DateTime.utc(2024, 8, 5),
    ratePerLal: 103.89,
    description: 'ATO spirits/OEB rate from 5 Aug 2024',
  ),
  ExciseRate(
    effectiveFrom: DateTime.utc(2025, 2, 3),
    ratePerLal: 104.31,
    description: 'ATO spirits/OEB rate from 3 Feb 2025',
  ),
  ExciseRate(
    effectiveFrom: DateTime.utc(2025, 8, 4),
    ratePerLal: 105.98,
    description: 'ATO spirits/OEB rate from 4 Aug 2025',
  ),
  ExciseRate(
    effectiveFrom: DateTime.utc(2026, 2, 2),
    ratePerLal: 107.99,
    description: 'ATO spirits/OEB >10% rate from 2 Feb 2026',
  ),
  ExciseRate(
    effectiveFrom: DateTime.utc(2026, 8, 3),
    ratePerLal: 110.15,
    description: 'ATO spirits/OEB rate from 3 Aug 2026',
  ),
];

/// Returns the Brisbane civil date represented by [value].
///
/// Stored timestamps are UTC instants, while rate effective dates are stored
/// as UTC midnight date markers. Brisbane has no daylight saving time.
DateTime australianExciseDate(DateTime value) {
  final brisbaneValue =
      value.isUtc ? value.add(const Duration(hours: 10)) : value;
  return DateTime(
    brisbaneValue.year,
    brisbaneValue.month,
    brisbaneValue.day,
  );
}

List<ExciseRate> mergeExciseRateSchedules({
  List<ExciseRate>? defaults,
  Iterable<ExciseRate> overrides = const [],
}) {
  final byDate = <String, ExciseRate>{};
  for (final rate in [...?defaults, ...overrides]) {
    if (!rate.ratePerLal.isFinite || rate.ratePerLal <= 0) continue;
    final date = australianExciseDate(rate.effectiveFrom);
    final key = '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
    byDate[key] = ExciseRate(
      effectiveFrom: DateTime.utc(date.year, date.month, date.day),
      ratePerLal: rate.ratePerLal,
      description: rate.description,
    );
  }
  return byDate.values.toList()
    ..sort((a, b) => a.effectiveFrom.compareTo(b.effectiveFrom));
}

bool hasValidAlcoholFields({
  required double volumeMl,
  required double abv,
}) {
  return volumeMl > 0 && abv > 0 && abv <= 1;
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
  date = australianExciseDate(date);
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
  final sorted = mergeExciseRateSchedules(
    defaults: rates ?? defaultAlcoholExciseRates,
  );
  if (sorted.isEmpty) {
    throw ArgumentError('At least one excise rate is required.');
  }

  final target = australianExciseDate(date);
  ExciseRate? selected;
  for (final rate in sorted) {
    final effectiveDate = australianExciseDate(rate.effectiveFrom);
    if (effectiveDate.isAfter(target)) break;
    selected = rate;
  }
  if (selected == null) {
    throw StateError(
      'No excise rate covers ${target.toIso8601String().substring(0, 10)}.',
    );
  }
  return selected;
}

double roundToDecimalPlaces(double value, int decimalPlaces) {
  final factor = _powerOfTen(decimalPlaces);
  return (value * factor).round() / factor;
}

double truncateToDecimalPlaces(double value, int decimalPlaces) {
  final factor = _powerOfTen(decimalPlaces);
  // Avoid dropping a cent when a mathematically exact decimal is represented
  // just below its value by binary floating-point (for example 107.99 * 10).
  final scaled = value * factor;
  final corrected = scaled >= 0 ? scaled + 1e-9 : scaled - 1e-9;
  return corrected.truncate() / factor;
}

double declaredExciseLals(double lals, {int decimalPlaces = 2}) =>
    roundToDecimalPlaces(lals, decimalPlaces);

double exciseDutyAud({
  required double lals,
  required DateTime date,
  List<ExciseRate>? rates,
  int lalDecimalPlaces = 2,
}) {
  final declaredLals = declaredExciseLals(
    lals,
    decimalPlaces: lalDecimalPlaces,
  );
  return truncateToDecimalPlaces(
    exciseValueAud(lals: declaredLals, date: date, rates: rates),
    2,
  );
}

double _powerOfTen(int decimalPlaces) {
  if (decimalPlaces < 0) {
    throw ArgumentError.value(decimalPlaces, 'decimalPlaces');
  }
  var result = 1.0;
  for (var i = 0; i < decimalPlaces; i++) {
    result *= 10;
  }
  return result;
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
  final normalizedStart = australianExciseDate(start);
  final normalizedEnd = australianExciseDate(end);
  if (!normalizedEnd.isAfter(normalizedStart)) {
    return RemissionPace(
      start: normalizedStart,
      end: normalizedEnd,
      capAud: remissionCapAudForFinancialYear(normalizedStart),
      allocatedRemissionAud: 0,
      allocatedLals: 0,
      averageRatePerLal:
          exciseRateForDate(normalizedStart, rates: rates).ratePerLal,
    );
  }

  final dailySegments = <RemissionPaceSegment>[];
  var day = normalizedStart;
  while (day.isBefore(normalizedEnd)) {
    final fyStart = australianFinancialYearStart(day);
    final fyEnd = australianFinancialYearEndExclusive(day);
    final capAud = remissionCapAudForFinancialYear(day);
    final fyDays = fyEnd.difference(fyStart).inDays;
    final allocatedAud = capAud / fyDays;
    final rate = exciseRateForDate(day, rates: rates).ratePerLal;
    final nextDay = day.add(const Duration(days: 1));
    final canExtend = dailySegments.isNotEmpty &&
        dailySegments.last.end.isAtSameMomentAs(day) &&
        dailySegments.last.financialYearStart.isAtSameMomentAs(fyStart) &&
        dailySegments.last.ratePerLal == rate;
    if (canExtend) {
      final previous = dailySegments.removeLast();
      dailySegments.add(RemissionPaceSegment(
        start: previous.start,
        end: nextDay,
        financialYearStart: fyStart,
        capAud: capAud,
        ratePerLal: rate,
        allocatedRemissionAud: previous.allocatedRemissionAud + allocatedAud,
        allocatedLals: previous.allocatedLals + allocatedAud / rate,
      ));
    } else {
      dailySegments.add(RemissionPaceSegment(
        start: day,
        end: nextDay,
        financialYearStart: fyStart,
        capAud: capAud,
        ratePerLal: rate,
        allocatedRemissionAud: allocatedAud,
        allocatedLals: allocatedAud / rate,
      ));
    }
    day = nextDay;
  }
  final allocatedAud = dailySegments.fold<double>(
    0,
    (sum, segment) => sum + segment.allocatedRemissionAud,
  );
  final allocatedLals = dailySegments.fold<double>(
    0,
    (sum, segment) => sum + segment.allocatedLals,
  );
  final averageRate = allocatedLals == 0
      ? exciseRateForDate(normalizedStart, rates: rates).ratePerLal
      : allocatedAud / allocatedLals;
  return RemissionPace(
    start: normalizedStart,
    end: normalizedEnd,
    capAud: remissionCapAudForFinancialYear(normalizedStart),
    allocatedRemissionAud: allocatedAud,
    allocatedLals: allocatedLals,
    averageRatePerLal: averageRate,
    segments: dailySegments,
  );
}
