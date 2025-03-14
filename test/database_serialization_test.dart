import 'package:bson/bson.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';
import 'utils/json_serialization_utils.dart';

/// Creates tests to verify that a model correctly handles database serialization
void createDatabaseSerializationTests<T extends DatabaseSerializable>({
  required String resourcePath,
  required T Function(Map<String, dynamic>) fromJson,
}) {
  group('$T Database Serialization', () {
    test('toDatabase() preserves ObjectId fields', () async {
      // Load test data
      final jsonData = loadJsonData(resourcePath);

      // Convert each test case
      for (final json in jsonData) {
        // Create model instance
        final model = fromJson(json);

        // Convert to database format
        final dbDoc = model.toDatabase();

        // Verify ObjectId fields are preserved
        for (final field in model.objectIdFields) {
          if (!dbDoc.containsKey(field)) continue;
          if (dbDoc[field] == null) continue;

          expect(
            dbDoc[field],
            isA<ObjectId>(),
            reason: '$field should be an ObjectId in database format',
          );

          // Verify the ObjectId value matches the original string
          if (json[field] != null && json[field] is String) {
            expect(
              (dbDoc[field] as ObjectId).oid,
              json[field],
              reason: '$field ObjectId value should match original',
            );
          }
        }

        // If model has nested objects, verify those too
        if (model.nestedDatabaseSerializables.isNotEmpty) {
          for (final entry in model.nestedDatabaseSerializables.entries) {
            final field = entry.key;
            final isList = entry.value;

            if (!dbDoc.containsKey(field)) continue;
            if (dbDoc[field] == null) continue;

            if (isList) {
              final list = dbDoc[field] as List;
              for (final item in list) {
                if (item is Map<String, dynamic> && item.containsKey('_id')) {
                  if (item['_id'] == null) continue;

                  expect(
                    item['_id'],
                    isA<ObjectId>(),
                    reason:
                        '${model.runtimeType} - Nested list item _id should be an ObjectId in database format',
                  );
                }
              }
            } else {
              final nestedDoc = dbDoc[field] as Map<String, dynamic>;
              if (nestedDoc.containsKey('_id') && nestedDoc['_id'] != null) {
                expect(
                  nestedDoc['_id'],
                  isA<ObjectId>(),
                  reason:
                      'Nested object _id should be an ObjectId in database format',
                );
              }
            }
          }
        }
      }
    });

    test('toDatabase() produces valid MongoDB documents', () async {
      // Load test data
      final jsonData = loadJsonData(resourcePath);

      // Convert each test case
      for (final json in jsonData) {
        // Create model instance
        final model = fromJson(json);

        // Convert to database format
        final dbDoc = model.toDatabase();

        // Verify the document structure is valid for MongoDB
        expect(
          () {
            // Basic validation of MongoDB document structure
            _validateMongoDocument(dbDoc);
          },
          returnsNormally,
          reason: 'Document should have valid structure for MongoDB',
        );
      }
    });
  });
}

/// Recursively validates a MongoDB document structure
void _validateMongoDocument(Map<String, dynamic> doc) {
  for (final entry in doc.entries) {
    // Check that all keys are strings
    expect(entry.key, isA<String>());

    // Check that all values are of valid BSON types
    final value = entry.value;
    if (value == null) continue;

    if (value is List) {
      // Recursively validate list items
      for (final item in value) {
        if (item is Map<String, dynamic>) {
          _validateMongoDocument(item);
        } else {
          _validateBsonValue(item, fieldName: '${entry.key}[]');
        }
      }
    } else if (value is Map<String, dynamic>) {
      // Recursively validate nested documents
      _validateMongoDocument(value);
    } else {
      _validateBsonValue(value, fieldName: entry.key);
    }
  }
}

/// Validates that a value is a valid BSON type
void _validateBsonValue(dynamic value, {required String fieldName}) {
  expect(
    value is num ||
        value is String ||
        value is bool ||
        value is DateTime ||
        value is ObjectId ||
        value == null,
    isTrue,
    reason: 'Field "$fieldName" has invalid BSON type: ${value.runtimeType}',
  );
}

void main() {
  createDatabaseSerializationTests<BulkStorageRegisterItemModel>(
      resourcePath: 'resources/bulkStorageRegisterItem.json',
      fromJson: BulkStorageRegisterItemModel.fromJson);
  createDatabaseSerializationTests<BulkStorageVesselModel>(
      resourcePath: 'resources/bulkStorageVessel.json',
      fromJson: BulkStorageVesselModel.fromJson);
  createDatabaseSerializationTests<CartModel>(
      resourcePath: 'resources/carts.json', fromJson: CartModel.fromJson);
  createDatabaseSerializationTests<CouponModel>(
      resourcePath: 'resources/coupons.json', fromJson: CouponModel.fromJson);
  createDatabaseSerializationTests<DeliveryAuthorityModel>(
      resourcePath: 'resources/deliveryAuthorities.json',
      fromJson: DeliveryAuthorityModel.fromJson);
  createDatabaseSerializationTests<DistillationRecordModel>(
      resourcePath: 'resources/distillationRecord.json',
      fromJson: DistillationRecordModel.fromJson);
  createDatabaseSerializationTests<ExciseReturnModel>(
      resourcePath: 'resources/exciseReturns.json',
      fromJson: ExciseReturnModel.fromJson);
  createDatabaseSerializationTests<FermentationRecordModel>(
      resourcePath: 'resources/fermentationRecord.json',
      fromJson: FermentationRecordModel.fromJson);
  createDatabaseSerializationTests<OrderModel>(
      resourcePath: 'resources/orders.json', fromJson: OrderModel.fromJson);
  createDatabaseSerializationTests<PackagingRunItemModel>(
      resourcePath: 'resources/packagingRunItem.json',
      fromJson: PackagingRunItemModel.fromJson);
  createDatabaseSerializationTests<PostcodeModel>(
      resourcePath: 'resources/postcodes.json',
      fromJson: PostcodeModel.fromJson);
  createDatabaseSerializationTests<ProductModel>(
      resourcePath: 'resources/products.json', fromJson: ProductModel.fromJson);
  createDatabaseSerializationTests<RawMaterialsRegisterModel>(
      resourcePath: 'resources/rawMaterialsRegister.json',
      fromJson: RawMaterialsRegisterModel.fromJson);
  createDatabaseSerializationTests<SaleModel>(
      resourcePath: 'resources/sales.json', fromJson: SaleModel.fromJson);
  createDatabaseSerializationTests<StockJournalModel>(
      resourcePath: 'resources/stockJournal.json',
      fromJson: StockJournalModel.fromJson);
  createDatabaseSerializationTests<VolumeTransferredRecordModel>(
      resourcePath: 'resources/volumeTransferredRecords.json',
      fromJson: VolumeTransferredRecordModel.fromJson);
}
