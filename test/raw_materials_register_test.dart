import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('RawMaterialsRegisterModel', () {
    test('timestamp should use explicit timestamp when provided', () {
      final explicitTime = DateTime(2024, 1, 1);
      final model = RawMaterialsRegisterModel(
        materialType: 'molasses',
        qtyIn: 100,
        qtyOut: 0,
        timestamp: explicitTime,
      );

      expect(model.timestamp, equals(explicitTime));
    });

    test('timestamp should fall back to ObjectId timestamp when not provided',
        () {
      final now = DateTime.now();
      final model = RawMaterialsRegisterModel(
        materialType: 'molasses',
        qtyIn: 100,
        qtyOut: 0,
      );

      // The ObjectId timestamp should be very close to now
      final difference = model.timestamp.difference(now).inSeconds.abs();
      expect(difference,
          lessThan(2)); // Allow 2 seconds difference for test execution
    });

    test('timestamp should be preserved during JSON serialization', () {
      final explicitTime = DateTime(2024, 1, 1);
      final model = RawMaterialsRegisterModel(
        materialType: 'molasses',
        qtyIn: 100,
        qtyOut: 0,
        timestamp: explicitTime,
      );

      final json = model.toJson();
      final deserialized = RawMaterialsRegisterModel.fromJson(json);

      expect(deserialized.timestamp, equals(explicitTime));
    });

    test(
        'timestamp should use ObjectId time when deserializing without timestamp',
        () {
      final model = RawMaterialsRegisterModel(
        materialType: 'molasses',
        qtyIn: 100,
        qtyOut: 0,
      );

      final json = model.toJson();
      // Explicitly remove timestamp from JSON
      json.remove('timestamp');

      final deserialized = RawMaterialsRegisterModel.fromJson(json);
      expect(deserialized.timestamp, equals(model.id.dateTime));
    });
  });
}
