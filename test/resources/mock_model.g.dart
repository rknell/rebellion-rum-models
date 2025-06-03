// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$MockStatusEnumMap = {
  MockStatus.active: 'active',
  MockStatus.inactive: 'inactive',
  MockStatus.pending: 'pending',
};

MockModel _$MockModelFromJson(Map<String, dynamic> json) => MockModel(
      id: json['id'] as String,
      name: json['name'] as String,
      count: (json['count'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      status: _$MockStatusEnumMap[json['status']]!,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => MockItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      parentItem: json['parentItem'] == null
          ? null
          : MockItemModel.fromJson(json['parentItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MockModelToJson(MockModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'isActive': instance.isActive,
      'status': _$MockStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'items': instance.items.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
      'metadata': instance.metadata,
      'parentItem': instance.parentItem?.toJson(),
    };

MockItemModel _$MockItemModelFromJson(Map<String, dynamic> json) =>
    MockItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$MockItemModelToJson(MockItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'quantity': instance.quantity,
    };
