import 'package:json_annotation/json_annotation.dart';

part 'postcode.g.dart';

@JsonSerializable()
class Postcode {
  @JsonKey(name: '_id')
  final String id;
  final String postcode;
  final String suburb;
  final String state;
  final String country;
  final double latitude;
  final double longitude;

  const Postcode({
    required this.id,
    required this.postcode,
    required this.suburb,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Postcode.fromJson(Map<String, dynamic> json) =>
      _$PostcodeFromJson(json);
  Map<String, dynamic> toJson() => _$PostcodeToJson(this);
}
