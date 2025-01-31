// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_materials_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawMaterialsRegisterModel _$RawMaterialsRegisterModelFromJson(
        Map<String, dynamic> json) =>
    RawMaterialsRegisterModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      invoiceNumber: json['invoiceNumber'] as String?,
      fermentationRecordId: const NullableObjectIdConverter()
          .fromJson(json['fermentationRecordId']),
      materialType: json['materialType'] as String,
      qtyIn: (json['qtyIn'] as num).toInt(),
      qtyOut: (json['qtyOut'] as num).toInt(),
    );

Map<String, dynamic> _$RawMaterialsRegisterModelToJson(
        RawMaterialsRegisterModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      if (instance.invoiceNumber case final value?) 'invoiceNumber': value,
      if (const NullableObjectIdConverter()
              .toJson(instance.fermentationRecordId)
          case final value?)
        'fermentationRecordId': value,
      'materialType': instance.materialType,
      'qtyIn': instance.qtyIn,
      'qtyOut': instance.qtyOut,
    };
