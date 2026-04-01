import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'reconciliation.g.dart';

/// Represents a cash and sales reconciliation record for a shift or day.
///
/// Contains sums, float, actuals, discrepancies, signatures, and sub-list of withdrawals.
@JsonSerializable(explicitToJson: true)
class ReconciliationModel extends DatabaseSerializable {
  /// Date of reconciliation (usually end-of-day)
  DateTime date;

  /// Name or signature of the person who completed reconciliation
  String signature;

  /// Total recorded sales in the system
  double totalSales;

  /// Actual Eftpos (card) sales counted/settled
  double actualEftposSales;

  /// Amount of cash counted in the till at end
  double cashInTill;

  /// Starting float (cash in till before trading/day)
  double startingFloat;

  /// Calculated or reported discrepancy (difference between actual and expected)
  double totalDiscrepancy;

  /// Free text explanation for discrepancy (if any)
  String discrepancyExplanation;

  /// List of withdrawals from till (e.g. for expenses, payouts)
  @JsonKey(defaultValue: <WithdrawalModel>[])
  List<WithdrawalModel> withdrawals;

  ReconciliationModel({
    super.id,
    required this.date,
    required this.signature,
    required this.totalSales,
    required this.actualEftposSales,
    required this.cashInTill,
    required this.startingFloat,
    required this.totalDiscrepancy,
    required this.discrepancyExplanation,
    List<WithdrawalModel>? withdrawals,
  }) : withdrawals = withdrawals ?? [];

  factory ReconciliationModel.fromJson(Map<String, dynamic> json) =>
      _$ReconciliationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReconciliationModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};

  @override
  Map<String, bool> get nestedDatabaseSerializables => {
        'withdrawals': true,
      };

  @override
  Map<String, Function> get nestedTypes => {
        'withdrawals': WithdrawalModel.fromJson,
      };
}

/// Represents a till/float withdrawal (e.g., cash paid out during shift)
@JsonSerializable()
class WithdrawalModel extends DatabaseSerializable {
  /// Purpose/reason for this withdrawal
  final String purpose;

  /// Amount of the withdrawal
  final double amount;

  WithdrawalModel({
    super.id,
    required this.purpose,
    required this.amount,
  });

  factory WithdrawalModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WithdrawalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
