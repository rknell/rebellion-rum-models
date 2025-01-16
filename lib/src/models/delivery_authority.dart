import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthorityModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  final String deliveryAuthorityNumber;
  final double lals;

  DeliveryAuthorityModel({
    ObjectId? id,
    required this.deliveryAuthorityNumber,
    required this.lals,
  }) : id = id ?? ObjectId();

  factory DeliveryAuthorityModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAuthorityModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryAuthorityModelToJson(this);
}
