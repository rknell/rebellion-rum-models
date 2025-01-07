import 'package:json_annotation/json_annotation.dart';

part 'raw_materials_register.g.dart';

@JsonSerializable()
class RawMaterialsRegister {
  @JsonKey(name: '_id')
  final String id;
  final String? invoiceNumber;
  final String? fermentationRecordId;
  final String materialType;
  final int qtyIn;
  final int qtyOut;

  const RawMaterialsRegister({
    required this.id,
    this.invoiceNumber,
    this.fermentationRecordId,
    required this.materialType,
    required this.qtyIn,
    required this.qtyOut,
  });

  factory RawMaterialsRegister.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterToJson(this);
}
