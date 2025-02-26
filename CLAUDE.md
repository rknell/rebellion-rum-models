# Rebellion Rum Models Commands & Guidelines

## Build Commands
```bash
# Generate JSON code
dart run build_runner build --delete-conflicting-outputs
# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs
# Run code analysis
dart analyze
# Run all tests
dart test
# Run a single test file
dart test test/path/to/test_file.dart
# Run tests with coverage
dart run coverage:test_with_coverage
```

## Code Style Guidelines

### Late Keyword Prohibition
- **NEVER use the `late` keyword** - It leads to runtime errors and makes code harder to reason about
- Use these alternatives instead:
  1. Factory constructors with private constructors for calculated values
  2. Nullable fields with required initialization
  3. Computed properties (getters) for on-demand calculation
  4. Builder pattern for complex initialization

### ObjectId Handling
- Every model with ObjectId fields **MUST** implement the `DatabaseSerializable` mixin
- Primary ID fields must use:
  ```dart
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  ```
- Nullable reference fields must use:
  ```dart
  @NullableObjectIdConverter()
  ObjectId? referenceId;
  ```
- The `objectIdFields` getter must include ALL ObjectId fields using the MongoDB field name:
  ```dart
  @override
  Set<String> get objectIdFields => {'_id', 'referenceId', 'otherId'};
  ```
- Initialize primary IDs in constructor: `id = id ?? ObjectId()`

### JSON Serialization
- All models must use `@JsonSerializable(explicitToJson: true)`
- Enum fields MUST include both `defaultValue` and `unknownEnumValue`:
  ```dart
  @JsonKey(
    defaultValue: Status.inactive,
    unknownEnumValue: Status.inactive
  )
  Status status;
  ```
- Never use explicit `JsonKey(name: )` when the field name is the same as JSON field
- Document migration strategies when removing enum values
- Test all serialization cases including invalid/unknown values

### Database Serialization
- Override `nestedDatabaseSerializables` for nested objects:
  ```dart
  @override
  Map<String, bool> get nestedDatabaseSerializables => {
    'nestedField': false,  // single object
    'nestedList': true,    // list of objects
  };
  ```
- Provide `nestedTypes` for proper deserialization:
  ```dart
  @override
  Map<String, Function> get nestedTypes => {
    'nestedField': NestedModel.fromJson,
    'nestedList': NestedModel.fromJson,
  };
  ```

### Coding Patterns
- Use appropriate constructor patterns:
  ```dart
  MyModel({
    ObjectId? id,
    this.nullableRefId,  // Optional parameter
    required this.requiredRefId,  // Required parameter
  }) : id = id ?? ObjectId();
  ```
- Keep alphabetical order in the `objectIdFields` set (except _id which comes first)
- Document enums with clear purpose and default value choice
- Handle deprecated values gracefully with appropriate migration strategy

### Testing Requirements
- Test serialization/deserialization of both nullable and non-nullable ObjectIds
- Test default ID generation when not provided
- Test null handling for nullable reference fields
- Test serialization with all valid enum values
- Test deserialization with unknown/invalid values
- Verify default value behavior for enums
- Test migration paths for deprecated values

## Code Review Checklist
- [ ] Model implements DatabaseSerializable mixin
- [ ] objectIdFields includes ALL ObjectId fields
- [ ] Appropriate converter annotations used (@ObjectIdConverter or @NullableObjectIdConverter)
- [ ] Constructor handles nullable/non-nullable fields appropriately
- [ ] JSON serialization annotations are complete
- [ ] Tests cover all ObjectId scenarios
- [ ] Enum serialization includes defaultValue and unknownEnumValue
- [ ] No use of late keyword
- [ ] Documentation explains purpose and default value choices