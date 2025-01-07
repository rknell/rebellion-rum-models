import 'package:json_annotation/json_annotation.dart';

part 'excise_return.g.dart';

@JsonSerializable()
class ExciseReturn {
  @JsonKey(name: '_id')
  final String id;
  final double totalLals;
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
