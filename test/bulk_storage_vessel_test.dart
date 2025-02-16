import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('BulkStorageVesselModel', () {
    test('name should return barcode when name is not set', () {
      final vessel = BulkStorageVesselModel(
        barcode: 'VESSEL123',
        name: null,
        capacity: 1000,
      );

      expect(vessel.name, equals('VESSEL123'));
    });

    test('name should return set name when available', () {
      final vessel = BulkStorageVesselModel(
        barcode: 'VESSEL123',
        name: 'Custom Vessel Name',
        capacity: 1000,
      );

      expect(vessel.name, equals('Custom Vessel Name'));
    });

    test('name should update correctly when changed', () {
      final vessel = BulkStorageVesselModel(
        barcode: 'VESSEL123',
        name: null,
        capacity: 1000,
      );

      // Initially should be barcode
      expect(vessel.name, equals('VESSEL123'));

      // Set a custom name
      vessel.name = 'New Name';
      expect(vessel.name, equals('New Name'));

      // Clear the name
      vessel.name = null;
      expect(vessel.name, equals('VESSEL123'));
    });
  });
}
