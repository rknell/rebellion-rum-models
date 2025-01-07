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

  // coverage:ignore-line
  factory Postcode.fromJson(Map<String, dynamic> json) =>
      _$PostcodeFromJson(json);
  // coverage:ignore-line
  Map<String, dynamic> toJson() => _$PostcodeToJson(this);
}
