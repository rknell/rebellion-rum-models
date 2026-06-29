import 'package:json_annotation/json_annotation.dart';
import 'package:rebellion_rum_models/src/json_helpers.dart';

part 'stock_journal.g.dart';

class StockMovementType {
  static const increment = 'increment';
  static const decrement = 'decrement';
  static const setAdjustment = 'setAdjustment';
  static const sale = 'sale';
  static const onlineOrder = 'onlineOrder';
  static const packagingRun = 'packagingRun';
  static const stocktake = 'stocktake';
  static const correction = 'correction';
  static const openingBalance = 'openingBalance';
}

/// Represents one immutable finished-goods stock movement.
///
/// The register is the source of truth for finished-goods stock. V1 tracks
/// product-level movements; optional location fields are kept for a later
/// location-aware register without rewriting historical entries.
@JsonSerializable()
class StockJournalModel extends DatabaseSerializable {
  /// Product barcode or stable product reference.
  String barcode;

  /// Signed movement quantity. Positive adds stock, negative removes it.
  double quantityDelta;

  /// Movement type. Use [StockMovementType] constants.
  String movementType;

  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime timestamp;

  /// System that emitted the movement, e.g. website, pointofsale, manager.
  String sourceSystem;

  /// Business document type, e.g. order, sale, packagingRun.
  String sourceDocumentType;

  /// Business document id/reference.
  String sourceDocumentId;

  /// Stable key that prevents duplicate movements for the same business event.
  String idempotencyKey;

  /// Optional source location for future location-aware stock.
  String? fromLocation;

  /// Optional destination location for future location-aware stock.
  String? toLocation;

  String? note;

  String? actor;

  int? previousStock;

  int? resultingStock;

  @JsonKey(fromJson: jsonToDateTime, toJson: dateTimeToJson)
  DateTime createdAt;

  StockJournalModel({
    super.id,
    required this.barcode,
    required this.quantityDelta,
    required this.movementType,
    required this.timestamp,
    required this.sourceSystem,
    required this.sourceDocumentType,
    required this.sourceDocumentId,
    required this.idempotencyKey,
    this.fromLocation,
    this.toLocation,
    this.note,
    this.actor,
    this.previousStock,
    this.resultingStock,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory StockJournalModel.fromJson(Map<String, dynamic> json) =>
      _$StockJournalModelFromJson(_normalizeStockJournalJson(json));

  @override
  Map<String, dynamic> toJson() => _$StockJournalModelToJson(this);

  @override
  Set<String> get objectIdFields => {'_id'};
}

Map<String, dynamic> _normalizeStockJournalJson(Map<String, dynamic> json) {
  final normalized = Map<String, dynamic>.from(json);
  final id = normalized['_id'];
  final idText = id?.toString() ?? '';
  final now = DateTime.now().toIso8601String();

  normalized['barcode'] ??= normalized['productRef'];
  normalized['quantityDelta'] ??= normalized['qty'];
  normalized['movementType'] ??= _legacyMovementType(normalized['type']);
  normalized['timestamp'] ??= normalized['createdAt'] ?? now;
  normalized['sourceSystem'] ??= 'legacy';
  normalized['sourceDocumentType'] ??= normalized['type'] ?? 'stockJournal';
  normalized['sourceDocumentId'] ??= idText.isEmpty ? 'unknown' : idText;
  normalized['idempotencyKey'] ??=
      'legacy-stock-journal:${idText.isEmpty ? normalized['barcode'] : idText}';
  normalized['fromLocation'] ??= normalized['from'];
  normalized['toLocation'] ??= normalized['to'];
  normalized['createdAt'] ??= normalized['timestamp'];

  return normalized;
}

String _legacyMovementType(dynamic type) {
  final value = type?.toString();
  if (value == null || value.isEmpty) {
    return StockMovementType.correction;
  }
  if (value == 'packaging') {
    return StockMovementType.packagingRun;
  }
  return value;
}
