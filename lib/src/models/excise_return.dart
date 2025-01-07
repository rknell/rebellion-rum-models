import 'package:json_annotation/json_annotation.dart';

part 'excise_return.g.dart';

/// Represents an excise duty return for regulatory compliance.
@JsonSerializable()
class ExciseReturn {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Total volume of spirits in LALs (Liters of Absolute Alcohol)
  final double totalLals;

  /// Whether remission has been applied to this return
  final bool remissionApplied;

  const ExciseReturn({
    required this.id,
    required this.totalLals,
    required this.remissionApplied,
  });

  factory ExciseReturn.fromJson(Map<String, dynamic> json) =>
      _$ExciseReturnFromJson(json);
  Map<String, dynamic> toJson() => _$ExciseReturnToJson(this);
}
