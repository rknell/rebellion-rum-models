import 'package:json_annotation/json_annotation.dart';

part 'postcode.g.dart';

@JsonSerializable()
class Postcode {
  @JsonKey(name: '_id')
  final String id;
  final String postcode;
  final String locality;
  final String state;
  final String combined;

  const Postcode({
    required this.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.combined,
  });

  factory Postcode.fromJson(Map<String, dynamic> json) =>
      _$PostcodeFromJson(json);
  Map<String, dynamic> toJson() => _$PostcodeToJson(this);
}
