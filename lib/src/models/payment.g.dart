// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      amount: (json['amount'] as num).toDouble(),
      type: $enumDecode(_$PaymentTypeEnumMap, json['type'],
          unknownValue: PaymentType.unknown),
      reference: json['reference'] as String?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'amount': instance.amount,
      'type': _$PaymentTypeEnumMap[instance.type]!,
      if (instance.reference case final value?) 'reference': value,
    };

const _$PaymentTypeEnumMap = {
  PaymentType.cash: 'cash',
  PaymentType.eftpos: 'eftpos',
  PaymentType.coupon: 'coupon',
  PaymentType.online: 'online',
  PaymentType.bank: 'bank',
  PaymentType.unknown: 'unknown',
};
