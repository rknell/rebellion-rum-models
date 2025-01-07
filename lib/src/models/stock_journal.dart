import 'package:json_annotation/json_annotation.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations and packaging operations.
@JsonSerializable()
class StockJournalModel {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// Barcode identifier for the product or vessel
  final String barcode;

  /// Type of stock movement (e.g., 'packaging')
  final String type;

  /// Source location or vessel ID
  final String from;

  /// Destination location or vessel ID
  final String to;

  /// Quantity moved
  final double qty;

  const StockJournalModel({
    required this.id,
    required this.barcode,
    required this.type,
    required this.from,
    required this.to,
    required this.qty,
  });

  factory StockJournalModel.fromJson(Map<String, dynamic> json) =>
      _$StockJournalModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockJournalModelToJson(this);
}
