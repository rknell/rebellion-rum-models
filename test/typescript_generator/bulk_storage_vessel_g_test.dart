import 'package:test/test.dart';

import '../../tools/generate_typescript_from_g_dart.dart';
import '../utils/test_logger.dart';

void main() {
  group('BulkStorageVesselModel generated code', () {
    // The exact content of the generated file as a hardcoded string
    const String inputData = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bulk_storage_vessel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BulkStorageVesselModel _\$BulkStorageVesselModelFromJson(
        Map<String, dynamic> json) =>
    BulkStorageVesselModel(
      id: const ObjectIdConverter().fromJson(json['_id']),
      barcode: json['barcode'] as String? ?? '',
      name: json['name'] as String?,
      capacity: (json['capacity'] as num?)?.toDouble() ?? 0,
      currentLals: (json['currentLals'] as num?)?.toDouble() ?? 0,
      status: \$enumDecodeNullable(
              _\$BulkStorageVesselStatusEnumMap, json['status']) ??
          BulkStorageVesselStatus.active,
      productId: const NullableObjectIdConverter().fromJson(json['productId']),
      needsStocktake: json['needsStocktake'] as bool? ?? false,
    );

Map<String, dynamic> _\$BulkStorageVesselModelToJson(
        BulkStorageVesselModel instance) =>
    <String, dynamic>{
      if (const ObjectIdConverter().toJson(instance.id) case final value?)
        '_id': value,
      'barcode': instance.barcode,
      'name': instance.name,
      'capacity': instance.capacity,
      'currentLals': instance.currentLals,
      'status': _\$BulkStorageVesselStatusEnumMap[instance.status]!,
      if (const NullableObjectIdConverter().toJson(instance.productId)
          case final value?)
        'productId': value,
      'needsStocktake': instance.needsStocktake,
    };

const _\$BulkStorageVesselStatusEnumMap = {
  BulkStorageVesselStatus.active: 'active',
  BulkStorageVesselStatus.decommissioned: 'decommissioned',
  BulkStorageVesselStatus.maintenance: 'maintenance',
};
''';

    test(
        'should contain fromJson function with all required fields for BulkStorageVesselModel',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);
      // Replace print statements
      TestLogger.debug('Generated TypeScript:');
      TestLogger.debug(result);
      expect(
        result.contains('export interface BulkStorageVesselModel'),
        isTrue,
        reason:
            'Generated TypeScript should contain the BulkStorageVesselModel interface',
      );

      // Verify that all fields from the model are present in the interface
      expect(result.contains('_id: any'), isTrue);
      expect(result.contains('barcode: string'), isTrue);
      expect(result.contains('name: string | null'), isTrue);
      expect(result.contains('capacity: number'), isTrue);
      expect(result.contains('currentLals: number'), isTrue);
      expect(result.contains('status: BulkStorageVesselStatus'), isTrue);
      expect(result.contains('productId: any'), isTrue);
      expect(result.contains('needsStocktake: boolean'), isTrue);
    });

    test(
        'should contain BulkStorageVesselStatus enum in the generated TypeScript',
        () async {
      final result =
          await generateTypeScriptString(null, inputContent: inputData);

      expect(
        result.contains('export enum BulkStorageVesselStatus'),
        isTrue,
        reason:
            'Generated TypeScript should contain the BulkStorageVesselStatus enum',
      );

      // Verify enum values
      expect(result.contains('active = "active"'), isTrue);
      expect(result.contains('decommissioned = "decommissioned"'), isTrue);
      expect(result.contains('maintenance = "maintenance"'), isTrue);
    });
  });
}
