import 'package:json_annotation/json_annotation.dart';

part 'packaging_run_item.g.dart';

@JsonSerializable()
class PackagingRunItem {
  @JsonKey(name: '_id')
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

  const PackagingRunItem({
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

  factory PackagingRunItem.fromJson(Map<String, dynamic> json) =>
      _$PackagingRunItemFromJson(json);
  Map<String, dynamic> toJson() => _$PackagingRunItemToJson(this);
}
