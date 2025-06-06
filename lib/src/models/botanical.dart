import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'botanical.g.dart';

/// Represents a botanical ingredient in the Rebellion Rum system.
///
/// This model stores information about botanical ingredients used in the
/// distillation process, including their scientific names, descriptions,
/// and associated images. Each botanical has a unique numeric identifier
/// and is designed to showcase the natural ingredients used in spirits.
///
/// Example:
/// ```dart
/// final botanical = BotanicalModel(
///   botanicalId: 8,
///   name: 'Juniper',
///   botanicalName: 'Juniperus communis',
///   description: 'Without juniper, there is no gin. When distilled, it adds a medicinal flavor with pine notes.',
///   image: '/assets/botanicals/juniper_berries.png',
/// );
/// ```
@JsonSerializable()
class BotanicalModel extends DatabaseSerializable {
  /// Unique numeric identifier for the botanical (from legacy system)
  @JsonKey(name: 'id')
  final int botanicalId;

  /// Common name of the botanical
  final String name;

  /// Scientific/botanical name of the plant
  final String botanicalName;

  /// Detailed description of the botanical and its characteristics
  final String description;

  /// Image path for the botanical
  final String image;

  /// Whether this botanical is currently active/available
  final bool isActive;

  /// Whether this botanical is featured in product descriptions
  final bool isFeatured;

  /// List of product IDs that use this botanical
  final List<String> productIds;

  /// Creation timestamp
  final DateTime? createdAt;

  /// Last updated timestamp
  final DateTime? updatedAt;

  BotanicalModel({
    super.id,
    required this.botanicalId,
    required this.name,
    required this.botanicalName,
    required this.description,
    required this.image,
    this.isActive = true,
    this.isFeatured = false,
    this.productIds = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory BotanicalModel.fromJson(Map<String, dynamic> json) =>
      _$BotanicalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BotanicalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
