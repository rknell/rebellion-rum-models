// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAuthorityModel _$DeliveryAuthorityModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAuthorityModel(
      id: json['_id'] as String,
      deliveryAuthorityNumber: json['deliveryAuthorityNumber'] as String,
      lals: (json['lals'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryAuthorityModelToJson(
        DeliveryAuthorityModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'deliveryAuthorityNumber': instance.deliveryAuthorityNumber,
      'lals': instance.lals,
    };
