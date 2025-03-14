import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'raw_materials_register.g.dart';

@JsonSerializable()
class RawMaterialsRegisterModel extends DatabaseSerializable {
  String? invoiceNumber;
  String? batchNumber;

  @NullableObjectIdConverter()
  ObjectId? fermentationRecordId;
  String materialType;
  int qtyIn;
  int qtyOut;

  @JsonKey(name: 'timestamp', includeIfNull: false)
  DateTime? _timestamp;

  DateTime get timestamp => _timestamp ?? id.dateTime;
  set timestamp(DateTime value) {
    _timestamp = value;
  }

  RawMaterialsRegisterModel(
      {super.id,
      this.invoiceNumber,
      this.batchNumber,
      this.fermentationRecordId,
      required this.materialType,
      required this.qtyIn,
      required this.qtyOut,
      DateTime? timestamp})
      : _timestamp = timestamp;

  factory RawMaterialsRegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RawMaterialsRegisterModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$RawMaterialsRegisterModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id', 'fermentationRecordId'};
}
