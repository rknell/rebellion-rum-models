import 'package:json_annotation/json_annotation.dart';

part 'excise_return.g.dart';

/// Represents an excise duty return for regulatory compliance.
///
/// Excise returns are required reports detailing the production,
/// storage, and movement of excisable goods (spirits). These records
/// are essential for tax purposes and regulatory compliance.
///
/// Example:
/// ```dart
/// final exciseReturn = ExciseReturn(
///   id: '123',
///   periodStart: DateTime(2024, 1, 1),
///   periodEnd: DateTime(2024, 1, 31),
///   totalProduction: 1500.0,
///   dutyPayable: 25000.0,
///   status: 'submitted',
/// );
/// ```
@JsonSerializable()
class ExciseReturn {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Start date of the reporting period
  final DateTime periodStart;

  /// End date of the reporting period
  final DateTime periodEnd;

  /// Total volume of spirits produced in the period (LALs)
  final double totalProduction;

  /// Total excise duty payable for the period
  final double dutyPayable;

  /// Current status of the return (e.g., 'draft', 'submitted', 'approved')
  final String status;

  const ExciseReturn({
    required this.id,
    required this.periodStart,
    required this.periodEnd,
    required this.totalProduction,
    required this.dutyPayable,
    required this.status,
  });

  factory ExciseReturn.fromJson(Map<String, dynamic> json) =>
      _$ExciseReturnFromJson(json);
  Map<String, dynamic> toJson() => _$ExciseReturnToJson(this);
}
