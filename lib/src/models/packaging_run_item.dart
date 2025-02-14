import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'packaging_run_item.g.dart';

@JsonSerializable()
class PackagingRunItemModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  String productBarcode;
  double unitSize;
  double strength;
  double unitsPackaged;
  double packagingLosses;
  double remaining;
  double volumeAvailable;
  double volumeRemaining;
  String exciseReturn;

  PackagingRunItemModel({
    ObjectId? id,
    required this.productBarcode,
    required this.unitSize,
    required this.strength,
    required this.unitsPackaged,
    required this.packagingLosses,
    required this.remaining,
    required this.volumeAvailable,
    required this.volumeRemaining,
    required this.exciseReturn,
  }) : id = id ?? ObjectId();

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
