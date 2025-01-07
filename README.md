# Rebellion Rum Models

A Dart library containing shared data models for Rebellion Rum projects. This library serves as the single source of truth for data structures across multiple projects.

## Features

- Centralized data models with JSON serialization
- MongoDB ObjectId support
- Automated model generation from database samples
- Comprehensive serialization testing

## Getting Started

### Prerequisites

- Dart SDK ≥3.6.0
- MongoDB instance (for model generation)

### Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  rebellion_rum_models: ^1.0.0
```

### Generating Models from Database

1. Run the export utility:
```bash
dart run bin/export_models.dart --connection-string="your_mongodb_connection_string"
```

2. Generate model classes:
```bash
./tools/build_runner.sh
```

## Usage

Import the models you need:

```dart
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
```

### Working with Models

Models are automatically serializable to/from JSON:

```dart
// Example with a User model
final user = User.fromJson(jsonMap);
final json = user.toJson();
```

### Security Notes

- The User model's password field is excluded by default
- Use `User.withPassword()` to include the password field when needed

## Development

### Running Tests

```bash
dart test
```

### Updating Models

1. Update the database
2. Re-run the export utility
3. Run the build runner
4. Run tests to ensure compatibility

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details 