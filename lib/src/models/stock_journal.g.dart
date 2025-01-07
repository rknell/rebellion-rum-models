// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockJournal _$StockJournalFromJson(Map<String, dynamic> json) => StockJournal(
      id: json['_id'] as String,
      barcode: json['barcode'] as String,
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      qty: (json['qty'] as num).toDouble(),
    );

Map<String, dynamic> _$StockJournalToJson(StockJournal instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      'type': instance.type,
      'from': instance.from,
      'to': instance.to,
      'qty': instance.qty,
    };
