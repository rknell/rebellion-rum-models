import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../json_helpers.dart';

part 'stocktake.g.dart';

@JsonSerializable()
class StocktakeModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;

  final String materialType;
  int currentStock;
  int newCount;
  final DateTime timestamp;

  StocktakeModel({
    ObjectId? id,
    required this.materialType,
    required this.currentStock,
    required this.newCount,
    DateTime? timestamp,
  })  : id = id ?? ObjectId(),
        timestamp = timestamp ?? DateTime.now();

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
}
