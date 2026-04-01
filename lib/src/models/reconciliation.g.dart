// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReconciliationModel _$ReconciliationModelFromJson(Map<String, dynamic> json) =>
    ReconciliationModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      date: DateTime.parse(json['date'] as String),
      signature: json['signature'] as String,
      totalSales: (json['totalSales'] as num).toDouble(),
      actualEftposSales: (json['actualEftposSales'] as num).toDouble(),
      cashInTill: (json['cashInTill'] as num).toDouble(),
      startingFloat: (json['startingFloat'] as num).toDouble(),
      tillOpeningValue: (json['tillOpeningValue'] as num).toDouble(),
      totalDiscrepancy: (json['totalDiscrepancy'] as num).toDouble(),
      discrepancyExplanation: json['discrepancyExplanation'] as String,
      withdrawals: (json['withdrawals'] as List<dynamic>?)
              ?.map((e) => WithdrawalModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ReconciliationModelToJson(
        ReconciliationModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'date': instance.date.toIso8601String(),
      'signature': instance.signature,
      'totalSales': instance.totalSales,
      'actualEftposSales': instance.actualEftposSales,
      'cashInTill': instance.cashInTill,
      'startingFloat': instance.startingFloat,
      'tillOpeningValue': instance.tillOpeningValue,
      'totalDiscrepancy': instance.totalDiscrepancy,
      'discrepancyExplanation': instance.discrepancyExplanation,
      'withdrawals': instance.withdrawals.map((e) => e.toJson()).toList(),
    };

WithdrawalModel _$WithdrawalModelFromJson(Map<String, dynamic> json) =>
    WithdrawalModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      purpose: json['purpose'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$WithdrawalModelToJson(WithdrawalModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'purpose': instance.purpose,
      'amount': instance.amount,
    };
