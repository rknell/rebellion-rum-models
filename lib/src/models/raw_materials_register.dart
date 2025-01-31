import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'raw_materials_register.g.dart';

@JsonSerializable()
class RawMaterialsRegisterModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String? invoiceNumber;
  String? batchNumber;

  @NullableObjectIdConverter()
  ObjectId? fermentationRecordId;
  String materialType;
  int qtyIn;
  int qtyOut;
  DateTime? timestamp;

  RawMaterialsRegisterModel({
    ObjectId? id,
    this.invoiceNumber,
    this.batchNumber,
    this.fermentationRecordId,
    required this.materialType,
    required this.qtyIn,
    required this.qtyOut,
    this.timestamp,
  }) : id = id ?? ObjectId();

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);
}
