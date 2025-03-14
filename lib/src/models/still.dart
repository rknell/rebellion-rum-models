import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'still.g.dart';

/// Represents a still in the distillery
@JsonSerializable()
class StillModel extends DatabaseSerializable {
  /// The name of the still
  String name;

  /// The capacity of the still in liters
  double capacityLiters;

  /// A description of the still (type, manufacturer, etc)
  String description;

  /// Whether the still is currently active
  bool isActive;

  /// Date when the still was commissioned
  DateTime commissionedDate;

  /// Date when the still was decommissioned (if applicable)
  DateTime? decommissionedDate;

  StillModel({
    super.id,
    required this.name,
    required this.capacityLiters,
    this.description = '',
    this.isActive = true,
    required this.commissionedDate,
    this.decommissionedDate,
  });

  factory StillModel.fromJson(Map<String, dynamic> json) =>
      _$StillModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StillModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
