#!/bin/bash

# Ensure we're in the project root
cd "$(dirname "$0")/.." || exit

# Run build_runner with delete-conflicting-outputs flag
echo "Running build_runner..."
dart run build_runner build --delete-conflicting-outputs

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build completed successfully!"
else
    echo "Build failed!"
    exit 1
fi 

dart tools/concat_models.dart