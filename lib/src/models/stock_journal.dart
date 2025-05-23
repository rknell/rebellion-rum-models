import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_journal.g.dart';

/// Represents a stock movement or adjustment record.
///
/// Stock journals track all changes to stock levels, including transfers
/// between locations and packaging operations.
@JsonSerializable()
class StockJournalModel extends DatabaseSerializable {
  /// Barcode identifier for the product or vessel
  String barcode;

  /// Type of stock movement (e.g., 'packaging')
  String type;

  /// Source location or vessel ID
  String from;

  /// Destination location or vessel ID
  String to;

  /// Quantity moved
  double qty;

  StockJournalModel({
    super.id,
    required this.barcode,
    required this.type,
    required this.from,
    required this.to,
    required this.qty,
  });

  factory StockJournalModel.fromJson(Map<String, dynamic> json) =>
      _$StockJournalModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$StockJournalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}
