// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailing_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailingListModel _$MailingListModelFromJson(Map<String, dynamic> json) =>
    MailingListModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      key: json['key'] as String,
      name: json['name'] as String,
      type: json['type'] as String? ?? 'custom',
      storefrontId: json['storefrontId'] as String? ?? 'rebellion',
      productBarcode: json['productBarcode'] as String?,
      productName: json['productName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MailingListModelToJson(MailingListModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'key': instance.key,
      'name': instance.name,
      'type': instance.type,
      'storefrontId': instance.storefrontId,
      if (instance.productBarcode case final value?) 'productBarcode': value,
      if (instance.productName case final value?) 'productName': value,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
