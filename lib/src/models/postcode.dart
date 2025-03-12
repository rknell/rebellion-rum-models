import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'postcode.g.dart';

/// Represents an Australian postcode and its associated location data.
///
/// This model stores information about Australian postcodes, including
/// the suburb, state, and delivery zone information. It's used for
/// shipping calculations and address validation.
///
/// Example:
/// ```dart
/// final postcode = PostcodeModel(
///   id: '123',
///   postcode: '3000',
///   suburb: 'Melbourne',
///   state: 'VIC',
///   deliveryZone: 'metro',
/// );
/// ```
@JsonSerializable()
class PostcodeModel extends DatabaseSerializable {
  /// Four-digit Australian postcode
  final String postcode;

  /// Suburb or locality name
  final String locality;

  /// State or territory code (e.g., 'VIC', 'NSW')
  final String state;

  /// Delivery zone classification for shipping
  final String combined;

  PostcodeModel({
    super.id,
    required this.postcode,
    required this.locality,
    required this.state,
    required this.combined,
  });

  factory PostcodeModel.fromJson(Map<String, dynamic> json) =>
      _$PostcodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostcodeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
