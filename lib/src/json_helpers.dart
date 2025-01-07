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
class ObjectIdConverter implements JsonConverter<ObjectId, dynamic> {
  const ObjectIdConverter();

  @override
  ObjectId fromJson(dynamic json) {
    // Return new ObjectId if input is null or empty
    if (json == null) return ObjectId();
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

  @override
  String toJson(ObjectId object) => object.oid;
}

/// Legacy converter that maintains MongoDB's extended JSON format.
/// Only use this if you specifically need {"$oid": "hex"} format.
class MongoObjectIdConverter
    implements JsonConverter<ObjectId, Map<String, dynamic>> {
  const MongoObjectIdConverter();

  @override
  ObjectId fromJson(Map<String, dynamic> json) =>
      ObjectId.fromHexString(json['\$oid'] as String);

  @override
  Map<String, dynamic> toJson(ObjectId object) => {'\$oid': object.oid};
}
