import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'packaging_material_definition.g.dart';

enum PackagingMaterialType {
  bottle,
  cap,
  sleeve,
  label,
}

@JsonSerializable()
class PackagingMaterialDefinitionModel extends DatabaseSerializable {
  PackagingMaterialType type;
  String displayName;
  String unit;
  int warningThreshold;
  bool isActive;
  String? productBarcode;
  double? labelTareWeightGrams;
  double? tenLabelSampleWeightGrams;

  PackagingMaterialDefinitionModel({
    super.id,
    required this.type,
    required this.displayName,
    this.unit = 'each',
    this.warningThreshold = 600,
    this.isActive = true,
    this.productBarcode,
    this.labelTareWeightGrams,
    this.tenLabelSampleWeightGrams,
  });

  double? get singleLabelWeightGrams {
    final sampleWeight = tenLabelSampleWeightGrams;
    if (sampleWeight == null || sampleWeight <= 0) {
      return null;
    }
    return sampleWeight / 10;
  }

  bool get hasLabelCalculationData =>
      type == PackagingMaterialType.label &&
      labelTareWeightGrams != null &&
      singleLabelWeightGrams != null;

  factory PackagingMaterialDefinitionModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PackagingMaterialDefinitionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$PackagingMaterialDefinitionModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
