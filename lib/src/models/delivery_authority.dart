import 'package:json_annotation/json_annotation.dart';

part 'delivery_authority.g.dart';

@JsonSerializable()
class DeliveryAuthority {
  @JsonKey(name: '_id')
  final String id;
  final String deliveryAuthorityNumber;
  final double lals;

  const DeliveryAuthority({
    required this.id,
    required this.deliveryAuthorityNumber,
    required this.lals,
  });

  factory DeliveryAuthority.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAuthorityFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryAuthorityToJson(this);
}
