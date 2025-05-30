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


# Generate TypeScript definitions from .g.dart files
echo "Generating TypeScript definitions from .g.dart files..."
dart run tools/generate_typescript_from_g_dart.dart

# Check if TypeScript generation was successful
if [ $? -eq 0 ]; then
    echo "TypeScript definitions generated successfully!"
    cp dist/models.d.ts ../rebellion-rum-website/src/types/shared-models.d.ts
else
    echo "TypeScript definition generation failed!"
    exit 1
fi

dart tools/concat_models.dart

tsc --noEmit dist/models.d.ts
cp dist/models.d.ts ../rebellion-rum-website/src/types/shared-models.d.ts