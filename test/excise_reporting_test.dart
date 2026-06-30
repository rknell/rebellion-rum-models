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

  test('weekly remission pace divides cap over the financial year', () {
    final pace = remissionPaceForPeriod(
      start: DateTime(2026, 7, 1),
      end: DateTime(2026, 7, 8),
    );

    expect(pace.allocatedRemissionAud, closeTo(400000 * 7 / 365, 0.000001));
    expect(pace.allocatedLals, closeTo((400000 * 7 / 365) / 107.99, 0.000001));
  });
}
