import 'package:json_annotation/json_annotation.dart';

part 'stock_journal.g.dart';

@JsonSerializable()
class StockJournal {
  @JsonKey(name: '_id')
  final String id;
  final String barcode;
  final String type;
  final String from;
  final String to;
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
