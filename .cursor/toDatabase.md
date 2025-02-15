# Using toDatabase Functions

## Overview

The `toDatabase` function is a critical part of the Rebellion Rum Models package that ensures proper serialization of models for MongoDB operations. It's provided by the `DatabaseSerializable` mixin and handles ObjectId preservation and nested object serialization.

## Basic Usage

```dart
// Create your model
final sale = SaleModel(
  items: [SaleItemModel(...)],
  payments: [PaymentModel(...)],
);

// For MongoDB operations, use toDatabase()
final dbDoc = sale.toDatabase();
await collection.insert(dbDoc);
```

## Key Features

1. **ObjectId Preservation**: Maintains ObjectId instances instead of converting them to strings
2. **Nested Object Handling**: Recursively processes nested objects that implement DatabaseSerializable
3. **List Support**: Handles lists of nested objects correctly

## Implementation Requirements

When implementing a model that uses `toDatabase`, you must:

1. Mix in the `DatabaseSerializable` mixin:
```dart
class YourModel with DatabaseSerializable {
  // ... model implementation
}
```

2. Override `objectIdFields` to specify which fields contain ObjectIds:
```dart
@override
Set<String> get objectIdFields => {'_id', 'otherObjectIdField'};
```

3. If you have nested objects, override `nestedDatabaseSerializables`:
```dart
@override
Map<String, bool> get nestedDatabaseSerializables => {
  'singleObject': false,  // false for single object
  'objectList': true,     // true for list of objects
};
```

4. Provide factory constructors for nested types:
```dart
@override
Map<String, Function> get nestedTypes => {
  'singleObject': NestedModel.fromJson,
  'objectList': NestedModel.fromJson,
};
```

## Common Patterns

### 1. Basic Model with Single ObjectId

```dart
@JsonSerializable()
class SimpleModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  
  String name;
  
  SimpleModel({ObjectId? id, required this.name}) : id = id ?? ObjectId();
  
  @override
  Set<String> get objectIdFields => {'_id'};
}
```

### 2. Model with Multiple ObjectIds

```dart
@JsonSerializable()
class ComplexModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  
  @ObjectIdConverter()
  ObjectId parentId;
  
  @ObjectIdConverter()
  ObjectId? optionalId;
  
  @override
  Set<String> get objectIdFields => {'_id', 'parentId', 'optionalId'};
}
```

### 3. Model with Nested Objects

```dart
@JsonSerializable()
class ParentModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  
  ChildModel child;
  List<ChildModel> children;
  
  @override
  Set<String> get objectIdFields => {'_id'};
  
  @override
  Map<String, bool> get nestedDatabaseSerializables => {
    'child': false,    // single object
    'children': true,  // list of objects
  };
  
  @override
  Map<String, Function> get nestedTypes => {
    'child': ChildModel.fromJson,
    'children': ChildModel.fromJson,
  };
}
```

## Best Practices

1. **Always Use ObjectIdConverter**:
   ```dart
   @ObjectIdConverter()
   ObjectId id;
   ```

2. **Handle Nullable ObjectIds**:
   ```dart
   @NullableObjectIdConverter()
   ObjectId? optionalId;
   ```

3. **Document Special Cases**:
   ```dart
   /// Custom handling for legacy data format
   @override
   Map<String, dynamic> toDatabase() {
     final doc = super.toDatabase();
     // Add custom handling here
     return doc;
   }
   ```

4. **Test Database Serialization**:
   ```dart
   test('toDatabase preserves ObjectIds', () {
     final model = YourModel(...);
     final dbDoc = model.toDatabase();
     expect(dbDoc['_id'], isA<ObjectId>());
   });
   ```

## Common Issues and Solutions

1. **Missing ObjectId Fields**
   - Problem: ObjectIds being converted to strings
   - Solution: Add field to `objectIdFields`

2. **Nested Objects Not Serializing**
   - Problem: Nested objects losing ObjectIds
   - Solution: Add to `nestedDatabaseSerializables` and `nestedTypes`

3. **Type Mismatches**
   - Problem: MongoDB rejecting document
   - Solution: Ensure all values are valid BSON types

## Related Documentation

- See `json_helpers.dart` for converter implementations
- Check `database_serialization_test.dart` for test examples
- Refer to MongoDB documentation for valid BSON types 