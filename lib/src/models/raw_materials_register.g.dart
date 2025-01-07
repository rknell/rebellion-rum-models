// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_materials_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMaterialsRegisterModel _$RawMaterialsRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RawMaterialsRegisterModel(
      id: json['_id'] as String,
      invoiceNumber: json['invoiceNumber'] as String?,
      fermentationRecordId: json['fermentationRecordId'] as String?,
      materialType: json['materialType'] as String,
      qtyIn: (json['qtyIn'] as num).toInt(),
      qtyOut: (json['qtyOut'] as num).toInt(),
    );

Map<String, dynamic> _$RawMaterialsRegisterModelToJson(
        RawMaterialsRegisterModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      if (instance.invoiceNumber case final value?) 'invoiceNumber': value,
      if (instance.fermentationRecordId case final value?)
        'fermentationRecordId': value,
      'materialType': instance.materialType,
      'qtyIn': instance.qtyIn,
      'qtyOut': instance.qtyOut,
    };
