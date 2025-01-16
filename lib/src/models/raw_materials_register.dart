import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'raw_materials_register.g.dart';

@JsonSerializable()
class RawMaterialsRegisterModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;
  final String? invoiceNumber;
  final String? fermentationRecordId;
  final String materialType;
  final int qtyIn;
  final int qtyOut;

  const RawMaterialsRegisterModel({
    required this.id,
    this.invoiceNumber,
    this.fermentationRecordId,
    required this.materialType,
    required this.qtyIn,
    required this.qtyOut,
  });

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);
}
