#!/bin/bash

echo "Running pre-commit preparation checks..."

# Run build_runner
echo "Running build_runner..."
dart run build_runner build --delete-conflicting-outputs
if [ $? -ne 0 ]; then
    echo "❌ Build runner failed."
    exit 1
fi


# Run model concatenation
echo "Concatenating models..."
dart run tools/concat_models.dart
if [ $? -ne 0 ]; then
    echo "❌ Model concatenation failed."
    exit 1
fi


# Run dart format and check if there are any changes
echo "Checking formatting..."
dart format .
if [ $? -ne 0 ]; then
    echo "❌ Dart format failed."
    exit 1
fi

# Run dart analyze
echo "Running analyzer..."
dart analyze
if [ $? -ne 0 ]; then
    echo "❌ Dart analyzer found issues."
    exit 1
fi

# Run tests
echo "Running tests..."
dart test
if [ $? -ne 0 ]; then
    echo "❌ Tests failed."
    exit 1
fi

echo "✅ All checks passed! Ready to commit."
exit 0 
