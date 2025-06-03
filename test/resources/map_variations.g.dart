// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_variations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapVariationsModel _$MapVariationsModelFromJson(Map<String, dynamic> json) =>
    MapVariationsModel(
      stringToInt: Map<String, int>.from(json['string_to_int'] as Map),
      stringToString: Map<String, String>.from(json['string_to_string'] as Map),
      stringToDynamic:
          Map<String, dynamic>.from(json['string_to_dynamic'] as Map),
      stringToDouble: Map<String, double>.from(json['string_to_double'] as Map),
      stringToBool: Map<String, bool>.from(json['string_to_bool'] as Map),
      nullableStringToInt: json['nullable_string_to_int'] == null
          ? null
          : Map<String, int>.from(json['nullable_string_to_int'] as Map),
    );

Map<String, dynamic> _$MapVariationsModelToJson(MapVariationsModel instance) =>
    <String, dynamic>{
      'string_to_int': instance.stringToInt,
      'string_to_string': instance.stringToString,
      'string_to_dynamic': instance.stringToDynamic,
      'string_to_double': instance.stringToDouble,
      'string_to_bool': instance.stringToBool,
      'nullable_string_to_int': instance.nullableStringToInt,
    };
