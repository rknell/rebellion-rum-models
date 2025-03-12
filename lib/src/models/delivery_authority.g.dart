// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_authority.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAuthorityModel _$DeliveryAuthorityModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryAuthorityModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      deliveryAuthorityNumber: json['deliveryAuthorityNumber'] as String,
      lals: (json['lals'] as num).toDouble(),
    );

Map<String, dynamic> _$DeliveryAuthorityModelToJson(
        DeliveryAuthorityModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'deliveryAuthorityNumber': instance.deliveryAuthorityNumber,
      'lals': instance.lals,
    };
