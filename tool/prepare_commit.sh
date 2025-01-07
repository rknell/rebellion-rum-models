#!/bin/bash

echo "Running pre-commit preparation checks..."

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