// ignore_for_file: avoid_print

import 'package:mongo_dart/mongo_dart.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converts ObjectIds to and from JSON format.
///
/// When deserializing (fromJson):
/// - Accepts ObjectId instances directly
/// - Accepts hex strings (e.g. "507f1f77bcf86cd799439011")
/// - Accepts MongoDB format (e.g. {"$oid": "507f1f77bcf86cd799439011"})
///
/// When serializing (toJson):
/// - Always outputs a hex string (e.g. "507f1f77bcf86cd799439011")
/// - This ensures consistency regardless of input format
/// - IMPORTANT: Do not change this behavior as it's required for database operations

/// Private helper method to convert JSON to ObjectId
ObjectId? _jsonToObjectId(dynamic json, {bool nullable = false}) {
  // Handle null/empty cases
  if (json == null) return nullable ? null : ObjectId();
  if (json is String && json.isEmpty) return ObjectId();

  // Case 1: Already an ObjectId
  if (json is ObjectId) return json;

  // Case 2: Hex string
  if (json is String) return ObjectId.fromHexString(json);

  // Case 3: MongoDB format with $oid
  if (json is Map) {
    if (json['\$oid'] != null) {
      return ObjectId.fromHexString(json['\$oid'] as String);
    }
    if (json['oid'] != null) {
      return ObjectId.fromHexString(json['oid'] as String);
    }
    // Return new ObjectId if map is empty or doesn't contain oid
    return ObjectId();
  }

  throw FormatException('Invalid ObjectId format: $json');
}

class ObjectIdConverter implements JsonConverter<ObjectId, dynamic> {
  const ObjectIdConverter();

  @override
  ObjectId fromJson(dynamic json) => _jsonToObjectId(json)!;

  @override
  String toJson(ObjectId object) => object.oid;
}

class NullableObjectIdConverter implements JsonConverter<ObjectId?, dynamic> {
  const NullableObjectIdConverter();

  @override
  ObjectId? fromJson(dynamic json) => _jsonToObjectId(json, nullable: true);

  @override
  String? toJson(ObjectId? object) => object?.oid;
}

/// A mixin that provides database serialization functionality for models
/// that use json_serializable and have ObjectId fields.
///
/// This mixin adds a [toDatabase] method that converts the model to a format
/// suitable for database storage, preserving ObjectId instances instead of
/// converting them to strings.
mixin DatabaseSerializable {
  /// Override this method to specify which fields contain ObjectIds
  /// Returns a set of field names that should be treated as ObjectIds
  /// This is the default implementation, but it can be overridden by extensions
  Set<String> get objectIdFields => {'_id'};

  /// Override this to specify nested objects that implement DatabaseSerializable
  /// Key is the field name, value is whether it's a list of objects
  Map<String, bool> get nestedDatabaseSerializables => {};

  /// Converts the model to a database-friendly format, preserving ObjectId instances.
  ///
  /// This method:
  /// 1. First converts the model to JSON using the standard toJson method
  /// 2. Then converts any ObjectId string representations back to ObjectId instances
  /// 3. Recursively handles nested objects that implement DatabaseSerializable
  /// 4. Returns a Map that can be directly used with MongoDB operations
  Map<String, dynamic> toDatabase() {
    // Get the raw data from the object
    final data = Map<String, dynamic>.from((this as dynamic).toJson());

    // Get the actual objectIdFields from the extension if available
    Set<String> fields;
    try {
      fields = (this as dynamic).objectIdFields as Set<String>;
    } catch (e) {
      fields = objectIdFields;
    }

    print('DEBUG: Converting to database format');
    print('DEBUG: Object ID fields: $fields');
    print('DEBUG: Initial data: $data');

    // Convert all ObjectId fields, preserving existing ObjectId instances
    for (final field in fields) {
      if (!data.containsKey(field)) continue;

      final value = data[field];
      if (value == null) continue;

      print(
          'DEBUG: Processing field $field with value $value (${value.runtimeType})');

      if (value is ObjectId) {
        // Already an ObjectId, keep it as is
        print('DEBUG: Field $field is already an ObjectId');
        continue;
      }

      if (value is String && value.isNotEmpty) {
        try {
          data[field] = ObjectId.fromHexString(value);
          print('DEBUG: Converted field $field from string to ObjectId');
        } catch (e) {
          print('WARNING: Failed to convert field $field to ObjectId: $e');
        }
      }
    }

    // Handle nested DatabaseSerializable objects
    for (final entry in nestedDatabaseSerializables.entries) {
      final field = entry.key;
      final isList = entry.value;

      if (!data.containsKey(field)) continue;

      if (isList) {
        // Handle list of nested objects
        if (data[field] is List) {
          final list = data[field] as List;
          data[field] = list.map((item) {
            if (item is DatabaseSerializable) {
              return item.toDatabase();
            } else if (item is Map<String, dynamic>) {
              final originalType = nestedTypes[field];
              if (originalType != null) {
                final instance = originalType(item);
                return (instance as DatabaseSerializable).toDatabase();
              }
            }
            return item;
          }).toList();
        }
      } else {
        // Handle single nested object
        if (data[field] is Map<String, dynamic>) {
          final originalType = nestedTypes[field];
          if (originalType != null) {
            final instance = originalType(data[field] as Map<String, dynamic>);
            data[field] = (instance as DatabaseSerializable).toDatabase();
          }
        }
      }
    }

    print('DEBUG: Final database data: $data');
    return data;
  }

  /// Override this to provide factory constructors for nested types
  /// Key is the field name, value is a function that creates an instance from JSON
  Map<String, Function> get nestedTypes => {};
}
