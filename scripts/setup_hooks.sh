#!/bin/bash

# Configure git to use the .githooks directory
git config core.hooksPath .githooks

# Make all hooks executable
chmod +x .githooks/*

echo "Git hooks configured successfully!" 