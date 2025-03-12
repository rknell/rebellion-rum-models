import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'excise_return.g.dart';

/// Represents an excise duty return for regulatory compliance.
@JsonSerializable()
class ExciseReturnModel extends DatabaseSerializable {
  /// Total volume of spirits in LALs (Liters of Absolute Alcohol)
  final double totalLals;

  /// Whether remission has been applied to this return
  final bool remissionApplied;

  String? referenceNumber;

  ExciseReturnModel({
    super.id,
    required this.totalLals,
    required this.remissionApplied,
  });

  factory ExciseReturnModel.fromJson(Map<String, dynamic> json) =>
      _$ExciseReturnModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExciseReturnModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
