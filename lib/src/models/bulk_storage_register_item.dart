import 'package:json_annotation/json_annotation.dart';

part 'bulk_storage_register_item.g.dart';

@JsonSerializable()
class BulkStorageRegisterItem {
  @JsonKey(name: '_id')
  final String id;
  final double lals;
  final bool feintsDestroyed;
  final bool wastage;
  final String notes;
  final String? fromChargeId;
  final String? fromVesselId;
  final String? toVesselId;
  final String? toChargeId;
  final String? toPackagingId;
  final String? fromPackagingId;

  const BulkStorageRegisterItem({
    required this.id,
    required this.lals,
    required this.feintsDestroyed,
    required this.wastage,
    required this.notes,
    this.fromChargeId,
    this.fromVesselId,
    this.toVesselId,
    this.toChargeId,
    this.toPackagingId,
    this.fromPackagingId,
  });

  factory BulkStorageRegisterItem.fromJson(Map<String, dynamic> json) =>
      _$BulkStorageRegisterItemFromJson(json);
  Map<String, dynamic> toJson() => _$BulkStorageRegisterItemToJson(this);
}
