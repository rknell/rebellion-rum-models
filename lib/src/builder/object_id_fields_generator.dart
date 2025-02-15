import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

/// Generator for automatically creating objectIdFields getters in DatabaseSerializable classes
class ObjectIdFieldsGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    for (var element in library.allElements) {
      if (element is ClassElement &&
          element.mixins.any((m) => m.element.name == 'DatabaseSerializable')) {
        final fields = _findObjectIdFields(element);
        if (fields.isNotEmpty) {
          buffer.writeln();
          buffer.writeln(
              '// Generated objectIdFields getter for ${element.name}');
          buffer.writeln(
              'extension ${element.name}ObjectIdFields on ${element.name} {');
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

    return buffer.toString();
  }

  Set<String> _findObjectIdFields(ClassElement classElement) {
    final fields = <String>{};

    for (var field in classElement.fields) {
      // Check for ObjectId type and converter annotations
      if (_isObjectIdField(field)) {
        // Get the MongoDB field name from @JsonKey annotation if present
        final mongoFieldName = _getMongoFieldName(field);
        fields.add(mongoFieldName);
      }
    }

    return fields;
  }

  bool _isObjectIdField(FieldElement field) {
    final hasObjectIdType = field.type.getDisplayString().contains('ObjectId');
    final hasObjectIdConverter = field.metadata.any((m) =>
        m.element?.displayName == 'ObjectIdConverter' ||
        m.element?.displayName == 'NullableObjectIdConverter');

    return hasObjectIdType && hasObjectIdConverter;
  }

  String _getMongoFieldName(FieldElement field) {
    // Look for @JsonKey annotation and extract the name parameter if present
    final jsonKeyAnnotation = field.metadata
        .where((m) => m.element?.displayName == 'JsonKey')
        .firstOrNull;

    if (jsonKeyAnnotation != null) {
      final nameArg =
          jsonKeyAnnotation.computeConstantValue()?.getField('name');
      if (nameArg != null && !nameArg.isNull) {
        return nameArg.toStringValue()!;
      }
    }

    // If no @JsonKey name is found, use the field name
    return field.name;
  }
}

Builder objectIdFieldsBuilder(BuilderOptions options) =>
    SharedPartBuilder([ObjectIdFieldsGenerator()], 'object_id_fields');
