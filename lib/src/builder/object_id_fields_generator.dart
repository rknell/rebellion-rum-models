import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for automatically creating objectIdFields getters in DatabaseSerializable classes
class ObjectIdFieldsGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    for (var element in library.allElements) {
      // We need to handle elements from LibraryReader carefully
      if (element.kind.name == 'CLASS' ||
          element.kind.name == 'ENUM' ||
          element.kind.name == 'MIXIN') {
        // Check if it's a class that implements DatabaseSerializable
        // We'll need to use dynamic typing since we can't use ClassElement directly
        final interfaces = _getInterfaces(element);
        if (interfaces
            .any((m) => _getElementName(m.element) == 'DatabaseSerializable')) {
          final fields = _findObjectIdFields(element);
          if (fields.isNotEmpty) {
            buffer.writeln();
            buffer.writeln(
                '// Generated objectIdFields getter for ${element.displayName}');
            buffer.writeln(
                'extension ${element.displayName}ObjectIdFields on ${element.displayName} {');
            buffer.writeln('  @override');
            buffer.writeln('  Set<String> get objectIdFields => {');
            // Sort fields but ensure '_id' comes first if present
            final sortedFields = fields.toList()..sort();
            if (sortedFields.contains('_id')) {
              sortedFields.remove('_id');
              sortedFields.insert(0, '_id');
            }
            for (var field in sortedFields) {
              buffer.writeln("    '$field',");
            }
            buffer.writeln('  };');
            buffer.writeln('}');
          }
        }
      }
    }

    return buffer.toString();
  }

  // Helper method to safely get interfaces from an element
  List<dynamic> _getInterfaces(dynamic element) {
    try {
      // For ClassElement, use interfaces
      return element.interfaces as List<dynamic>;
    } catch (e) {
      // For InterfaceElement2, use allSupertypes (if available)
      if (element is InterfaceElement2) {
        return element.allSupertypes;
      }
      return [];
    }
  }

  // Helper method to get element name safely
  String _getElementName(dynamic element) {
    if (element == null) return '';

    try {
      // Try getting name3 (Element2 style)
      final name3 = element.name3;
      if (name3 != null) return name3;

      // Fall back to displayName
      return element.displayName;
    } catch (e) {
      // Fall back to plain name (old element style)
      return element.name ?? '';
    }
  }

  Set<String> _findObjectIdFields(dynamic classElement) {
    final fields = <String>{};

    // Get fields from either Element2 or old Element
    final elementFields = _getFields(classElement);

    for (var field in elementFields) {
      // Check for ObjectId type and converter annotations
      if (_isObjectIdField(field)) {
        // Get the MongoDB field name from @JsonKey annotation if present
        final mongoFieldName = _getMongoFieldName(field);
        fields.add(mongoFieldName);
      }
    }

    return fields;
  }

  // Helper method to safely get fields from an element
  List<dynamic> _getFields(dynamic element) {
    try {
      // For InterfaceElement2, use fields2
      if (element is InterfaceElement2) {
        return element.fields2;
      }

      // Try fields for old Element
      return element.fields as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  bool _isObjectIdField(dynamic field) {
    final hasObjectIdType = field.type.getDisplayString().contains('ObjectId');

    // Get metadata safely
    final metadata = _getMetadata(field);

    final hasObjectIdConverter = metadata.any((m) {
      final elementName = _getElementDisplayName(m.element) ??
          _getElementDisplayName(m.element2);
      return elementName == 'ObjectIdConverter' ||
          elementName == 'NullableObjectIdConverter';
    });

    return hasObjectIdType && hasObjectIdConverter;
  }

  // Helper method to get displayName safely
  String? _getElementDisplayName(dynamic element) {
    if (element == null) return null;
    try {
      return element.displayName;
    } catch (e) {
      return null;
    }
  }

  // Helper method to safely get metadata from a field
  List<dynamic> _getMetadata(dynamic field) {
    try {
      // Use metadata field or property regardless of element type
      // As we're using dynamic typing, this will work with any element
      // that has metadata, including both old and new APIs
      return field.metadata as List<dynamic>;
    } catch (e) {
      // If that fails, try annotations directly if it exists
      try {
        return field.annotations as List<dynamic>;
      } catch (e2) {
        return [];
      }
    }
  }

  String _getMongoFieldName(dynamic field) {
    // Look for @JsonKey annotation and extract the name parameter if present
    final metadata = _getMetadata(field);

    final jsonKeyAnnotation = metadata.where((m) {
      final elementName = _getElementDisplayName(m.element) ??
          _getElementDisplayName(m.element2);
      return elementName == 'JsonKey';
    }).firstOrNull;

    if (jsonKeyAnnotation != null) {
      final nameArg =
          jsonKeyAnnotation.computeConstantValue()?.getField('name');
      if (nameArg != null && !nameArg.isNull) {
        return nameArg.toStringValue()!;
      }
    }

    // If no @JsonKey name is found, use the field name
    // Try both name styles
    try {
      final name3 = field.name3;
      if (name3 != null) return name3;
      return field.name ?? field.displayName;
    } catch (e) {
      return field.name ?? field.displayName;
    }
  }
}

Builder objectIdFieldsBuilder(BuilderOptions options) =>
    SharedPartBuilder([ObjectIdFieldsGenerator()], 'object_id_fields');
