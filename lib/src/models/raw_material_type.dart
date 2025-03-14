import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'raw_material_type.g.dart';

/// Represents a type of raw material used in distillation.
///
/// This model serves as a lookup table between sugar type and specific gravity,
/// which is needed for tax calculations and tracking raw materials.
///
/// Example:
/// ```dart
/// final molasses = RawMaterialTypeModel(
///   name: 'Molasses',
///   specificGravity: 1.4,
/// );
/// ```
@JsonSerializable()
class RawMaterialTypeModel extends DatabaseSerializable {
  /// The name of the raw material type (e.g., Molasses, Sugar Cane)
  String name;

  /// The specific gravity of the raw material
  /// Used in calculations for conversion rates and tax purposes
  double specificGravity;

  RawMaterialTypeModel({
    super.id,
    required this.name,
    required this.specificGravity,
  });

  factory RawMaterialTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialTypeModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RawMaterialTypeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
