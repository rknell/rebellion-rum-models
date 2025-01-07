#!/bin/bash

# Remove old coverage data
rm -rf coverage

# Create coverage directory
mkdir -p coverage

# Run tests with coverage
dart run coverage:test_with_coverage

# Generate LCOV report
genhtml coverage/lcov.info -o coverage/html

# Output coverage percentage
lcov --summary coverage/lcov.info

echo "Coverage report generated at coverage/html/index.html" 