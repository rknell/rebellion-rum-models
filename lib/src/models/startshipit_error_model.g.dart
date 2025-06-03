// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startshipit_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StartShipItErrorModel _$StartShipItErrorModelFromJson(
        Map<String, dynamic> json) =>
    StartShipItErrorModel(
      message: json['message'] as String,
      details: json['details'] as String,
    );

Map<String, dynamic> _$StartShipItErrorModelToJson(
        StartShipItErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'details': instance.details,
    };
