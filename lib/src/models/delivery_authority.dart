import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthorityModel {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final String id;
  final String deliveryAuthorityNumber;
  final double lals;

  const DeliveryAuthorityModel({
    required this.id,
    required this.deliveryAuthorityNumber,
    required this.lals,
  });

  factory DeliveryAuthorityModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAuthorityModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryAuthorityModelToJson(this);
}
