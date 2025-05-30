import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('StillModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'still.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StillModel _\$StillModelFromJson(Map<String, dynamic> json) => StillModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      name: json['name'] as String,
      capacityLiters: (json['capacityLiters'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
      commissionedDate: DateTime.parse(json['commissionedDate'] as String),
      decommissionedDate: json['decommissionedDate'] == null
          ? null
          : DateTime.parse(json['decommissionedDate'] as String),
    );

Map<String, dynamic> _\$StillModelToJson(StillModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'name': instance.name,
      'capacityLiters': instance.capacityLiters,
      'description': instance.description,
      'isActive': instance.isActive,
      'commissionedDate': instance.commissionedDate.toIso8601String(),
      if (instance.decommissionedDate?.toIso8601String() case final value?)
        'decommissionedDate': value,
    };
''';

    test(
        'should contain fromJson function with all required fields for StillModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);

      expect(
        result.contains('export interface StillModel'),
        isTrue,
        reason: 'Generated TypeScript should contain the StillModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('_id: string'), isTrue);
      expect(result.contains('name: string'), isTrue);
      expect(result.contains('capacityLiters: number'), isTrue);
      expect(result.contains('description: string'), isTrue);
      expect(result.contains('isActive: boolean'), isTrue);
      expect(result.contains('commissionedDate: string'), isTrue);
      expect(result.contains('decommissionedDate: string | null'), isTrue);
    });
  });
}
