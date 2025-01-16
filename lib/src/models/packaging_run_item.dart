import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'packaging_run_item.g.dart';

@JsonSerializable()
class PackagingRunItemModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;
  final String productBarcode;
  final double unitSize;
  final double strength;
  final double unitsPackaged;
  final double packagingLosses;
  final double remaining;
  final double volumeAvailable;
  final double volumeRemaining;
  final String exciseReturn;

  const PackagingRunItemModel({
    required this.id,
    required this.productBarcode,
    required this.unitSize,
    required this.strength,
    required this.unitsPackaged,
    required this.packagingLosses,
    required this.remaining,
    required this.volumeAvailable,
    required this.volumeRemaining,
    required this.exciseReturn,
  });

  factory PackagingRunItemModel.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemModelToJson(this);
}
