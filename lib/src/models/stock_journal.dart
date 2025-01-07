import 'package:json_annotation/json_annotation.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations and packaging operations.
@JsonSerializable()
class StockJournal {
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

  const StockJournal({
    required this.id,
    required this.barcode,
    required this.type,
    required this.from,
    required this.to,
    required this.qty,
  });

  factory StockJournal.fromJson(Map<String, dynamic> json) =>
      _$StockJournalFromJson(json);
  Map<String, dynamic> toJson() => _$StockJournalToJson(this);
}
