// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_journal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockJournalModel _$StockJournalModelFromJson(Map<String, dynamic> json) =>
    StockJournalModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      type: json['type'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      qty: (json['qty'] as num).toDouble(),
    );

Map<String, dynamic> _$StockJournalModelToJson(StockJournalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'type': instance.type,
      'from': instance.from,
      'to': instance.to,
      'qty': instance.qty,
    };
