# Rebellion Rum Models

A Dart library to maintain consistent data models across multiple projects using MongoDB as the source of truth.

## Overview

This library serves as a central location to store data models for reuse in other projects, ensuring database schema consistency across all dependent projects.

## Features

- Centralized data models for MongoDB collections
- JSON serialization/deserialization using json_serializable
- Sample data management for testing and development
- Comprehensive test coverage for all models
- Built-in export utility for MongoDB collections

## Getting Started

### Prerequisites

- Dart SDK ≥3.6.0
- MongoDB instance (for sample data export)

### Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  rebellion_rum_models:
    git: https://github.com/your-username/rebellion-rum-models.git
```

### Usage

Import the models you need:

```dart
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
```

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

### Tests

Run all tests:

```bash
dart test
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

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

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