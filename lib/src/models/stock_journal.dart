import 'package:json_annotation/json_annotation.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations, adjustments, and stock takes. Each entry provides
/// an audit trail of stock movements and modifications.
///
/// Example:
/// ```dart
/// final journal = StockJournal(
///   id: '123',
///   timestamp: DateTime.now(),
///   type: 'transfer',
///   productId: 'PROD-001',
///   quantity: 50,
///   fromLocation: 'WHSE-A',
///   toLocation: 'WHSE-B',
///   notes: 'Regular stock rotation',
/// );
/// ```
@JsonSerializable()
class StockJournal {
  /// MongoDB document ID
  @JsonKey(name: '_id')
  final String id;

  /// When the stock movement occurred
  final DateTime timestamp;

  /// Type of stock movement (e.g., 'transfer', 'adjustment', 'stocktake')
  final String type;

  /// Reference to the affected product
  final String productId;

  /// Quantity moved or adjusted
  final int quantity;

  /// Source location for transfers
  final String? fromLocation;

  /// Destination location for transfers
  final String? toLocation;

  /// Additional information about the movement
  final String? notes;

  const StockJournal({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.productId,
    required this.quantity,
    this.fromLocation,
    this.toLocation,
    this.notes,
  });

  factory StockJournal.fromJson(Map<String, dynamic> json) =>
      _$StockJournalFromJson(json);
  Map<String, dynamic> toJson() => _$StockJournalToJson(this);
}
