import 'package:json_annotation/json_annotation.dart';

part 'postcode.g.dart';

/// Represents an Australian postcode and its associated location data.
///
/// This model stores information about Australian postcodes, including
/// the suburb, state, and delivery zone information. It's used for
/// shipping calculations and address validation.
///
/// Example:
/// ```dart
/// final postcode = Postcode(
///   id: '123',
///   postcode: '3000',
///   suburb: 'Melbourne',
///   state: 'VIC',
///   deliveryZone: 'metro',
/// );
/// ```
@JsonSerializable()
class Postcode {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Four-digit Australian postcode
  final String postcode;

  /// Suburb or locality name
  final String suburb;

  /// State or territory code (e.g., 'VIC', 'NSW')
  final String state;

  /// Delivery zone classification for shipping
  final String deliveryZone;

  const Postcode({
    required this.id,
    required this.postcode,
    required this.suburb,
    required this.state,
    required this.deliveryZone,
  });

  factory Postcode.fromJson(Map<String, dynamic> json) =>
      _$PostcodeFromJson(json);
  Map<String, dynamic> toJson() => _$PostcodeToJson(this);
}
