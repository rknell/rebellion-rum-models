// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericTypesModel _$GenericTypesModelFromJson(Map<String, dynamic> json) =>
    GenericTypesModel(
      // List types
      stringList: (json['string_list'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      intList:
          (json['int_list'] as List<dynamic>).map((e) => e as int).toList(),
      doubleList: (json['double_list'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      boolList:
          (json['bool_list'] as List<dynamic>).map((e) => e as bool).toList(),
      dynamicList: json['dynamic_list'] as List<dynamic>,
      objectList: (json['object_list'] as List<dynamic>)
          .map((e) => NestedObjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nullableStringList: (json['nullable_string_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),

      // Set types
      stringSet:
          (json['string_set'] as List<dynamic>).map((e) => e as String).toSet(),
      intSet: (json['int_set'] as List<dynamic>).map((e) => e as int).toSet(),
      objectSet: (json['object_set'] as List<dynamic>)
          .map((e) => NestedObjectModel.fromJson(e as Map<String, dynamic>))
          .toSet(),

      // More complex Map types
      intToStringMap: (json['int_to_string_map'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), e as String),
      ),
      objectToListMap: (json['object_to_list_map'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            NestedObjectModel.fromJson(json['key_$k'] as Map<String, dynamic>),
            (e as List<dynamic>).map((e) => e as String).toList()),
      ),

      // Nested generics
      listOfMaps: (json['list_of_maps'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(k, e as String),
              ))
          .toList(),
      mapOfLists: (json['map_of_lists'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$GenericTypesModelToJson(GenericTypesModel instance) =>
    <String, dynamic>{
      'string_list': instance.stringList,
      'int_list': instance.intList,
      'double_list': instance.doubleList,
      'bool_list': instance.boolList,
      'dynamic_list': instance.dynamicList,
      'object_list': instance.objectList,
      'nullable_string_list': instance.nullableStringList,
      'string_set': instance.stringSet.toList(),
      'int_set': instance.intSet.toList(),
      'object_set': instance.objectSet.toList(),
      'int_to_string_map':
          instance.intToStringMap.map((k, e) => MapEntry(k.toString(), e)),
      'object_to_list_map':
          instance.objectToListMap.map((k, e) => MapEntry('key_${k.id}', e)),
      'list_of_maps': instance.listOfMaps,
      'map_of_lists': instance.mapOfLists,
    };

NestedObjectModel _$NestedObjectModelFromJson(Map<String, dynamic> json) =>
    NestedObjectModel(
      id: json['id'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$NestedObjectModelToJson(NestedObjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
    };
