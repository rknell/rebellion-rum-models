# Rebellion Rum Models - Technical Specification

## Overview
A Dart library to maintain consistent data models across multiple projects using MongoDB as the source of truth. This library serves as a central location to store data models for reuse in other projects, ensuring database schema consistency across all dependent projects.

## Purpose
- Provide a single source of truth for data models across multiple projects
- Ensure immediate reflection of schema changes in all dependent projects
- Minimize duplication of model definitions
- Standardize data handling across the Rebellion Rum ecosystem

## Core Requirements

### Database Utility
- Command-line utility to download collection samples
- Accept MongoDB connection string as CLI parameter
- Download latest 50 records from each collection
- Export collections to separate JSON files
- Collection names will be used as filenames
- Files stored in `lib/src/sample_data/`
- Utility will be used as the basis for model generation

### Model Generation
- Analyze downloaded JSON files to create model structure
- Generate JsonSerializable dart classes for each collection
- Create comprehensive tests for serialization/deserialization
- Use downloaded reference data for test cases
- Ensure full compatibility with existing data structures

### Model Architecture
- Use JsonSerializable for serialization
- Implement custom ObjectId serialization using provided json_helpers.dart
- Models follow singular naming (e.g., User for users collection)
- No nested model grouping required
- Plain Old Dart Objects (POCO) approach
- Models must be immutable
- All fields should be non-nullable unless explicitly required

### Security Requirements
- User collection password field handling:
  - Default: Exclude password field
  - Separate method to include password when needed
  - Password must always be stored hashed and salted
  - No plain text passwords in any model

### Technical Requirements
- Dart SDK: ≥3.6.0
- MongoDB support only
- No direct database operations in models
- Models operate on JSON only
- All models must implement toString() for debugging
- All models must implement equality operators
- All models must be immutable

### Testing Requirements
- Focus on serialization/deserialization testing
- Use sample data from MongoDB export
- 100% coverage for JSON conversion
- Test both valid and invalid JSON inputs
- Test all custom field serializers
- Test password field exclusion/inclusion for User model
- Loop over each record in downloaded reference data for testing

### Documentation
- DartDoc compatible documentation
- Minimal but clear model documentation
- Markdown README
- No API documentation required
- Each model class must have example usage in comments
- Document any field constraints or validation rules

### Build System
- Use build_runner for code generation
- Maintain .cursorrules file for common commands
- Shell script for build automation
- Clear error messages for build failures

### Future Considerations
- Designed for gradual growth
- Support for model relationships if needed
- No versioning required
- Potential for field validation in future
- Possible integration with GraphQL schemas

### File Structure
```
rebellion_rum_models/
├── bin/
│   └── export_models.dart
├── lib/
│   ├── src/
│   │   ├── models/
│   │   ├── sample_data/
│   │   └── json_helpers.dart
│   └── rebellion_rum_models.dart
├── test/
├── tools/
│   └── build_runner.sh
├── .cursorrules
├── SPEC.md
└── README.md
```

### Maintenance Requirements
- Regular updates to sample data
- Documentation updates with model changes
- Test updates with new model features
- Backward compatibility considerations
- Immediate reflection of database schema changes 