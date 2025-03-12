import 'package:json_annotation/json_annotation.dart';
import '../json_helpers.dart';

part 'stocktake.g.dart';

@JsonSerializable()
class StocktakeModel extends DatabaseSerializable {
  final String materialType;
  int currentStock;
  int newCount;
  final DateTime timestamp;

  StocktakeModel({
    super.id,
    required this.materialType,
    required this.currentStock,
    required this.newCount,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  String get displayName {
    final names = {
      'raw_sugar': 'Raw Sugar',
      'white_sugar': 'White Sugar',
      'molasses': 'Molasses',
      'golden_syrup': 'Golden Syrup',
      'brown_sugar': 'Brown Sugar',
    };
    return names[materialType] ?? materialType;
  }

  int get difference => newCount - currentStock;

  factory StocktakeModel.fromJson(Map<String, dynamic> json) =>
      _$StocktakeModelFromJson(json);
  Map<String, dynamic> toJson() => _$StocktakeModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
