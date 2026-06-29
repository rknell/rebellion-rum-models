import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'raw_material_definition.g.dart';

@JsonSerializable()
class RawMaterialDefinitionModel extends DatabaseSerializable {
  String materialKey;
  String displayName;
  String unit;
  int sortOrder;
  bool isActive;

  RawMaterialDefinitionModel({
    super.id,
    required this.materialKey,
    required this.displayName,
    required this.unit,
    this.sortOrder = 0,
    this.isActive = true,
  });

  factory RawMaterialDefinitionModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialDefinitionModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RawMaterialDefinitionModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
