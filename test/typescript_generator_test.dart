import 'package:test/test.dart';
import '../tools/generate_typescript_from_g_dart.dart';

void main() {
  group('ObjectIdConverter Detection Tests', () {
    test('should detect ObjectIdConverter and return string type', () {
      const assignmentCode = "const ObjectIdConverter().fromJson(json['_id'])";
      final result = inferTypeScriptTypeFromJson(assignmentCode, '_id');
      expect(result, equals('string'));
    });

    test(
        'should detect NullableObjectIdConverter and return string | null type',
        () {
      const assignmentCode =
          "const NullableObjectIdConverter().fromJson(json['parentId'])";
      final result = inferTypeScriptTypeFromJson(assignmentCode, 'parentId');
      expect(result, equals('string | null'));
    });

    test('should handle ObjectIdConverter with nullable context', () {
      const assignmentCode =
          "json['_id'] == null ? null : const ObjectIdConverter().fromJson(json['_id'])";
      final result = inferTypeScriptTypeFromJson(assignmentCode, '_id');
      expect(result, equals('string | null'));
    });

    test('should not interfere with other converter types', () {
      const assignmentCode = "json['name'] as String";
      final result = inferTypeScriptTypeFromJson(assignmentCode, 'name');
      expect(result, equals('string'));
    });

    test('should handle complex ObjectIdConverter expressions', () {
      const assignmentCode =
          "id: const ObjectIdConverter().fromJson(json['_id']),";
      final result = inferTypeScriptTypeFromJson(assignmentCode, 'id');
      expect(result, equals('string'));
    });
  });

  group('Full TypeScript Generation with ObjectId', () {
    test('should generate correct TypeScript for model with ObjectId fields',
        () async {
      const mockGDartContent = '''
ProductModel _\$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _\$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'name': instance.name,
    };
''';

      final result =
          await generateTypeScriptString(null, inputContent: mockGDartContent);

      expect(result, contains('export interface ProductModel {'));
      expect(result, contains('_id: string;'));
      expect(result, contains('barcode: string;'));
      expect(result, contains('name: string | null;'));
    });
  });
}
