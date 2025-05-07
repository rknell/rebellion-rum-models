# TypeScript Generator

This directory contains tools for generating TypeScript definitions from Dart models.

## Overview

The `generate_typescript_from_g_dart.dart` script analyzes the generated `.g.dart` files from json_serializable to create accurate TypeScript definitions. This ensures that the TypeScript types match exactly what will be serialized to/from JSON.

## Features

- Supports all Dart primitive types, collections, and model references
- Handles enums with proper string literal values
- Intelligently detects field renaming (snake_case, camelCase, etc.)
- Preserves nullability information
- Works with generic types like List<T>, Map<K, V>, and Set<T>

## Field Renaming Support

The TypeScript generator automatically detects and preserves field renaming configurations (e.g., `@JsonSerializable(fieldRename: FieldRename.snake)`). It does this by:

1. Extracting JSON key accesses directly from constructor args in fromJson methods
2. Scanning class toJson methods for key-to-field mappings
3. Applying field name patterns to all models consistently

This ensures that models that use snake_case or other field naming conventions properly generate matching TypeScript interfaces.

## Usage

```bash
dart run tools/generate_typescript_from_g_dart.dart
```

Options:
- `--input, -i`: Path to the folder containing models (default: 'lib/src/models')
- `--output, -o`: Output file path (default: 'dist/models.d.ts')
- `--help, -h`: Show help message

## Design Principles

1. **Generic over specific**: The generator avoids hard-coding specific model or field names
2. **Accurate type mapping**: Maps Dart types to appropriate TypeScript equivalents
3. **Preservation of naming conventions**: Respects the JSON naming conventions used in the models
4. **Intelligent inference**: Uses context clues to infer types when explicit information is not available

