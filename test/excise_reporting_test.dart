import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('FY2026/27 remission cap is 400000 AUD', () {
    expect(remissionCapAudForFinancialYear(DateTime(2026, 7, 1)), 400000);
    expect(remissionCapAudForFinancialYear(DateTime(2027, 6, 30)), 400000);
  });

  test('FY2025/26 remission cap remains 350000 AUD', () {
    expect(remissionCapAudForFinancialYear(DateTime(2026, 6, 30)), 350000);
  });

  test('excise value uses dated rate table', () {
    final value = exciseValueAud(lals: 10, date: DateTime(2026, 7, 1));

    expect(value, closeTo(1079.90, 0.000001));
  });

  test('3 August 2026 rate boundary follows the Brisbane civil date', () {
    expect(
      exciseRateForDate(DateTime.utc(2026, 8, 2, 13, 59)).ratePerLal,
      107.99,
    );
    expect(
      exciseRateForDate(DateTime.utc(2026, 8, 2, 14)).ratePerLal,
      110.15,
    );
  });

  test('manual rates replace matching defaults without removing history', () {
    final rates = mergeExciseRateSchedules(
      defaults: defaultAlcoholExciseRates,
      overrides: [
        ExciseRate(
          effectiveFrom: DateTime.utc(2026, 8, 3),
          ratePerLal: 111,
          description: 'manual correction',
        ),
      ],
    );

    expect(exciseRateForDate(DateTime(2026, 8, 2), rates: rates).ratePerLal,
        107.99);
    expect(
        exciseRateForDate(DateTime(2026, 8, 3), rates: rates).ratePerLal, 111);
  });

  test('a schedule does not apply its first future rate retrospectively', () {
    expect(
      () => exciseRateForDate(
        DateTime(2026, 8, 2),
        rates: [
          ExciseRate(
            effectiveFrom: DateTime.utc(2026, 8, 3),
            ratePerLal: 110.15,
            description: 'future',
          ),
        ],
      ),
      throwsStateError,
    );
  });

  test('return duty uses two-decimal declared LALs and truncates cents', () {
    expect(
      exciseDutyAud(lals: 1.2349, date: DateTime(2026, 8, 3)),
      135.48,
    );
  });

  test('weekly remission pace divides cap over the financial year', () {
    final pace = remissionPaceForPeriod(
      start: DateTime(2026, 7, 1),
      end: DateTime(2026, 7, 8),
    );

    expect(pace.allocatedRemissionAud, closeTo(400000 * 7 / 365, 0.000001));
    expect(pace.allocatedLals, closeTo((400000 * 7 / 365) / 107.99, 0.000001));
  });

  test('remission pace splits a period at an excise rate boundary', () {
    final pace = remissionPaceForPeriod(
      start: DateTime(2026, 7, 30),
      end: DateTime(2026, 8, 6),
    );
    final dailyAud = 400000 / 365;

    expect(pace.segments, hasLength(2));
    expect(pace.segments.first.allocatedLals,
        closeTo(dailyAud * 4 / 107.99, 0.000001));
    expect(pace.segments.last.allocatedLals,
        closeTo(dailyAud * 3 / 110.15, 0.000001));
  });
}
