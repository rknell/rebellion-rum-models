import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
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
class RawMaterialTypeModel with DatabaseSerializable {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  /// The name of the raw material type (e.g., Molasses, Sugar Cane)
  String name;

  /// The specific gravity of the raw material
  /// Used in calculations for conversion rates and tax purposes
  double specificGravity;

  RawMaterialTypeModel({
    ObjectId? id,
    required this.name,
    required this.specificGravity,
  }) : id = id ?? ObjectId();

  factory RawMaterialTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialTypeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
