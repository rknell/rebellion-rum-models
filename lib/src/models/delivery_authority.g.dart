// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAuthority _$DeliveryAuthorityFromJson(Map<String, dynamic> json) =>
    DeliveryAuthority(
      id: json['_id'] as String,
      deliveryAuthorityNumber: json['deliveryAuthorityNumber'] as String,
      lals: (json['lals'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryAuthorityToJson(DeliveryAuthority instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'deliveryAuthorityNumber': instance.deliveryAuthorityNumber,
      'lals': instance.lals,
    };
