// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reconciliation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReconciliationModel _$ReconciliationModelFromJson(Map<String, dynamic> json) =>
    ReconciliationModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      openingTime: jsonToDateTime(json['openingTime']),
      closingTime: jsonToNullableDateTime(json['closingTime']),
      signature: json['signature'] as String?,
      totalSales: (json['totalSales'] as num?)?.toDouble() ?? 0,
      actualEftposSales: (json['actualEftposSales'] as num?)?.toDouble() ?? 0,
      eodCashInTill: (json['eodCashInTill'] as num?)?.toDouble() ?? 0,
      couponTotalAmount: (json['couponTotalAmount'] as num?)?.toDouble() ?? 0,
      startingFloat: (json['startingFloat'] as num?)?.toDouble() ?? 0,
      totalDiscrepancy: (json['totalDiscrepancy'] as num?)?.toDouble() ?? 0,
      discrepancyExplanation: json['discrepancyExplanation'] as String? ?? '',
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
      'openingTime': dateTimeToJson(instance.openingTime),
      if (dateTimeToJsonNullable(instance.closingTime) case final value?)
        'closingTime': value,
      if (instance.signature case final value?) 'signature': value,
      'totalSales': instance.totalSales,
      'actualEftposSales': instance.actualEftposSales,
      'eodCashInTill': instance.eodCashInTill,
      'couponTotalAmount': instance.couponTotalAmount,
      'startingFloat': instance.startingFloat,
      'totalDiscrepancy': instance.totalDiscrepancy,
      if (instance.discrepancyExplanation case final value?)
        'discrepancyExplanation': value,
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
