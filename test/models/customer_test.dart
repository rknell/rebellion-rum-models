import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('CustomerModel', () {
    test('mergeSanitized should update allowed fields only', () {
      // Create original customer
      final original = CustomerModel(
        firstName: 'Original',
        lastName: 'Customer',
        email: 'original@example.com',
        phone: '1234567890',
        addressLine1: '123 Original St',
        city: 'Original City',
        state: 'OS',
        postcode: '12345',
        isWholesale: false,
        preferences: {CustomerPreferences.darkRum},
      );

      // Create source customer with changes
      final source = CustomerModel(
        firstName: 'New',
        lastName: 'Person',
        email: 'new@example.com',
        phone: '0987654321',
        addressLine1: '456 New St',
        addressLine2: 'Apt 2',
        city: 'New City',
        state: 'NS',
        postcode: '54321',
        country: 'New Zealand',
        isWholesale: true, // This should not be updated
        preferences: {CustomerPreferences.gin, CustomerPreferences.vodka},
      );

      // Apply mergeSanitized
      original.mergeSanitized(source);

      // Verify updated fields
      expect(original.firstName, equals('New'));
      expect(original.lastName, equals('Person'));
      expect(original.email, equals('new@example.com'));
      expect(original.phone, equals('0987654321'));
      expect(original.addressLine1, equals('456 New St'));
      expect(original.addressLine2, equals('Apt 2'));
      expect(original.city, equals('New City'));
      expect(original.state, equals('NS'));
      expect(original.postcode, equals('54321'));
      expect(original.country, equals('New Zealand'));
      expect(original.preferences,
          equals({CustomerPreferences.gin, CustomerPreferences.vodka}));

      // Verify isWholesale was not changed
      expect(original.isWholesale, equals(false));
    });

    test('mergeSanitized should handle null optional fields', () {
      // Create original customer with some optional fields
      final original = CustomerModel(
        firstName: 'Original',
        lastName: 'Customer',
        email: 'original@example.com',
        phone: '1234567890',
        addressLine1: '123 Original St',
        addressLine2: 'Suite 100',
        city: 'Original City',
        state: 'OS',
        postcode: '12345',
        companyName: 'Original Company',
        preferences: {CustomerPreferences.darkRum},
      );

      // Create source customer with null optional fields
      final source = CustomerModel(
        firstName: 'New',
        lastName: 'Person',
        email: 'new@example.com',
        phone: '0987654321',
        addressLine1: '456 New St',
        addressLine2: null,
        city: 'New City',
        state: 'NS',
        postcode: '54321',
        companyName: null,
        preferences: {},
      );

      // Apply mergeSanitized
      original.mergeSanitized(source);

      // Verify optional fields were updated to null
      expect(original.addressLine2, isNull);
      expect(original.companyName, isNull);
      expect(original.preferences, isEmpty);
    });

    test('mergeSanitized should return the instance for method chaining', () {
      // Create customers
      final original = CustomerModel(
        firstName: 'Original',
        lastName: 'Customer',
        email: 'original@example.com',
        phone: '1234567890',
        addressLine1: '123 Original St',
        city: 'Original City',
        state: 'OS',
        postcode: '12345',
      );

      final source = CustomerModel(
        firstName: 'New',
        lastName: 'Person',
        email: 'new@example.com',
        phone: '0987654321',
        addressLine1: '456 New St',
        city: 'New City',
        state: 'NS',
        postcode: '54321',
      );

      // Verify the same instance is returned
      final result = original.mergeSanitized(source);
      expect(result, same(original));
    });
  });
}
