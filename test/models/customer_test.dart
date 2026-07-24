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

    test('should serialize trade application status and details', () {
      final customer = CustomerModel(
        firstName: 'Trade',
        lastName: 'Buyer',
        email: 'trade@example.com',
        phone: '0400000000',
        addressLine1: '1 Trade Street',
        city: 'Yatala',
        state: 'QLD',
        postcode: '4207',
        companyName: 'Trade Venue Pty Ltd',
        abn: '12345678901',
        venueType: 'Bottle shop',
        tradeStatus: 'pending',
        tradeApplicationMessage: 'Interested in Fuckhead wholesale.',
      );
      customer.password = 'hashed-password';

      final publicJson = customer.toJson();
      expect(publicJson['abn'], equals('12345678901'));
      expect(publicJson['venueType'], equals('Bottle shop'));
      expect(publicJson['tradeStatus'], equals('pending'));
      expect(publicJson['tradeApplicationMessage'],
          equals('Interested in Fuckhead wholesale.'));
      expect(publicJson.containsKey('password'), isFalse);

      final databaseJson = customer.toDatabase();
      expect(databaseJson['password'], equals('hashed-password'));

      final deserialized = CustomerModel.fromJson(databaseJson);
      expect(deserialized.abn, equals('12345678901'));
      expect(deserialized.venueType, equals('Bottle shop'));
      expect(deserialized.tradeStatus, equals('pending'));
      expect(deserialized.password, equals('hashed-password'));
    });

    test('mergeSanitized should not update trade approval fields', () {
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
        tradeStatus: 'pending',
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
        isWholesale: true,
        tradeStatus: 'approved',
      );

      original.mergeSanitized(source);

      expect(original.isWholesale, isFalse);
      expect(original.tradeStatus, equals('pending'));
    });

    test('mates rates entitlement defaults false and round-trips', () {
      final legacyCustomer = CustomerModel.fromJson({
        '_id': '507f1f77bcf86cd799439011',
        'firstName': 'Legacy',
        'lastName': 'Customer',
        'email': 'legacy@example.com',
        'phone': '0400000000',
        'addressLine1': '1 Legacy Street',
        'city': 'Yatala',
        'state': 'QLD',
        'postcode': '4207',
        'country': 'AU',
        'isWholesale': false,
        'preferences': <String>[],
      });
      expect(legacyCustomer.isMatesRates, isFalse);

      final entitled = CustomerModel(
        firstName: 'Mate',
        lastName: 'Customer',
        email: 'mate@example.com',
        phone: '0400000000',
        addressLine1: '2 Mates Street',
        city: 'Yatala',
        state: 'QLD',
        postcode: '4207',
        isMatesRates: true,
      );

      expect(entitled.toJson()['isMatesRates'], isTrue);
      expect(
        CustomerModel.fromJson(entitled.toDatabase()).isMatesRates,
        isTrue,
      );
    });

    test('mergeSanitized should not update mates rates entitlement', () {
      final original = CustomerModel(
        firstName: 'Mate',
        lastName: 'Customer',
        email: 'mate@example.com',
        phone: '0400000000',
        addressLine1: '2 Mates Street',
        city: 'Yatala',
        state: 'QLD',
        postcode: '4207',
        isMatesRates: true,
      );
      final submittedProfile = CustomerModel(
        firstName: 'Updated',
        lastName: 'Customer',
        email: 'mate@example.com',
        phone: '0400000001',
        addressLine1: '3 Updated Street',
        city: 'Yatala',
        state: 'QLD',
        postcode: '4207',
        isMatesRates: false,
      );

      original.mergeSanitized(submittedProfile);

      expect(original.firstName, equals('Updated'));
      expect(original.isMatesRates, isTrue);
    });

    test('should serialize account metadata and hide reset secrets publicly',
        () {
      final accountCreatedAt = DateTime.utc(2026, 6, 8, 1, 2, 3);
      final resetExpiresAt = DateTime.utc(2026, 6, 8, 2, 2, 3);
      final customer = CustomerModel(
        firstName: 'Account',
        lastName: 'Customer',
        email: 'account@example.com',
        phone: '0400000000',
        addressLine1: '1 Account Street',
        city: 'Yatala',
        state: 'QLD',
        postcode: '4207',
        accountCreatedAt: accountCreatedAt,
        passwordResetTokenHash: 'hashed-reset-token',
        passwordResetExpiresAt: resetExpiresAt,
      );
      customer.password = 'hashed-password';

      final publicJson = customer.toJson();
      expect(publicJson['accountCreatedAt'],
          equals(accountCreatedAt.toIso8601String()));
      expect(publicJson.containsKey('password'), isFalse);
      expect(publicJson.containsKey('passwordResetTokenHash'), isFalse);
      expect(publicJson.containsKey('passwordResetExpiresAt'), isFalse);

      final databaseJson = customer.toDatabase();
      expect(databaseJson['password'], equals('hashed-password'));
      expect(
          databaseJson['passwordResetTokenHash'], equals('hashed-reset-token'));
      expect(databaseJson['passwordResetExpiresAt'], equals(resetExpiresAt));

      final deserialized = CustomerModel.fromJson(databaseJson);
      expect(deserialized.accountCreatedAt, equals(accountCreatedAt));
      expect(deserialized.passwordResetTokenHash, equals('hashed-reset-token'));
      expect(deserialized.passwordResetExpiresAt, equals(resetExpiresAt));
    });
  });
}
