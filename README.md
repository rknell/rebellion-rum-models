# Rebellion Rum Models

This package contains the data models used across the Rebellion Rum applications.

## Features

- JSON serialization for all models using `json_serializable`
- MongoDB/Database serialization with proper ObjectId handling
- Type-safe model definitions with documentation
- Comprehensive test coverage

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  rebellion_rum_models:
    git:
      url: https://github.com/your-org/rebellion-rum-models.git
      ref: main  # or specific tag/commit
```

## Usage

### Basic Model Usage

```dart
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

// Create a new product
final product = ProductModel(
  barcode: '123456789',
  name: 'Premium Dark Rum',
  price: 49.99,
  volume: 700,
  abv: 0.40,
);

// Convert to JSON
final json = product.toJson();

// Create from JSON
final fromJson = ProductModel.fromJson(json);
```

### Database Serialization

All models implement the `DatabaseSerializable` mixin, which provides proper MongoDB serialization with ObjectId handling. This ensures that ObjectId fields are preserved when saving to MongoDB:

```dart
// Create a model
final sale = SaleModel(
  items: [SaleItemModel(...)],
  payments: [PaymentModel(...)],
);

// For JSON serialization (converts ObjectIds to strings)
final json = sale.toJson();

// For MongoDB operations (preserves ObjectIds)
final dbDoc = sale.toDatabase();
await collection.insert(dbDoc);
```

#### How It Works

The `DatabaseSerializable` mixin provides:

1. Automatic ObjectId preservation for database operations
2. Support for nested objects and lists
3. Type-safe serialization

Each model specifies its ObjectId fields and nested objects:

```dart
class YourModel with DatabaseSerializable {
  @JsonKey(name: '_id')
  @ObjectIdConverter()
  final ObjectId id;
  
  // ... other fields ...

  @override
  Set<String> get objectIdFields => {'_id', 'otherObjectIdField'};

  // If you have nested objects that also need database serialization:
  @override
  Map<String, bool> get nestedDatabaseSerializables => {
    'nestedField': false,  // single object
    'nestedList': true,    // list of objects
  };

  @override
  Map<String, Function> get nestedTypes => {
    'nestedField': NestedModel.fromJson,
    'nestedList': NestedModel.fromJson,
  };
}
```

## Testing

Run the tests:

```bash
dart test
```

The test suite includes:
- JSON serialization tests
- Database serialization tests
- Model validation tests

## Contributing

1. Fork the repository
2. Create your feature branch
3. Add tests for any new functionality
4. Ensure all tests pass
5. Create a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Development Commands

### Build

Generate JSON serialization code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Watch Mode

Auto-generate code on file changes:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Documentation

Generate documentation:

```bash
dart doc .
```

### Format Code

Format all Dart files:

```bash
dart format .
```

### Export MongoDB Sample Data

The project includes a utility to export sample data from MongoDB collections. This is typically only needed when:
- Setting up the project for the first time
- Updating models to match significant database schema changes
- Refreshing test data with newer examples

To export sample data:

```bash
dart run bin/export_models.dart --connection-string='mongodb://your-connection-string'
```

This will:
- Connect to your MongoDB database
- Export the 50 most recent documents from each collection
- Save them as JSON files in `lib/src/sample_data/`
- Use these files for model generation and testing

Note: Use single quotes around the connection string if it contains special characters.

## Project Structure

```
rebellion_rum_models/
├── bin/
│   └── export_models.dart     # MongoDB export utility
├── lib/
│   ├── src/
│   │   ├── models/           # Generated model classes
│   │   ├── sample_data/      # Exported MongoDB samples
│   │   └── json_helpers.dart # JSON serialization helpers
│   └── rebellion_rum_models.dart
├── test/                     # Model tests
└── README.md
```

## Development Setup

### Git Hooks

This repository includes pre-commit hooks that:
- Run the build_runner
- Format code
- Run the analyzer
- Run tests

To set up the hooks, run:

```bash
./scripts/setup_hooks.sh
```

This will configure git to use the hooks in the `.githooks` directory. 