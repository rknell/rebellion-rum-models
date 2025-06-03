import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('NewsletterSignupModel', () {
    test('should create with required contactInfo', () {
      final signup = NewsletterSignupModel(
        contactInfo: 'test@example.com',
      );

      expect(signup.contactInfo, equals('test@example.com'));
      expect(signup.isActive, isTrue);
      expect(signup.signupDate, isNull);
      expect(signup.id, isA<ObjectId>());
    });

    test('should create with optional fields', () {
      final signupDate = DateTime.now();
      final signup = NewsletterSignupModel(
        contactInfo: 'test@example.com',
        signupDate: signupDate,
        isActive: false,
      );

      expect(signup.contactInfo, equals('test@example.com'));
      expect(signup.signupDate, equals(signupDate));
      expect(signup.isActive, isFalse);
    });

    test('should use effectiveSignupDate from signupDate when available', () {
      final signupDate = DateTime(2024, 1, 15, 10, 30);
      final signup = NewsletterSignupModel(
        contactInfo: 'test@example.com',
        signupDate: signupDate,
      );

      expect(signup.effectiveSignupDate, equals(signupDate));
    });

    test('should use effectiveSignupDate from ObjectId when signupDate is null',
        () {
      final signup = NewsletterSignupModel(
        contactInfo: 'test@example.com',
      );

      // The effective date should come from the ObjectId timestamp
      expect(signup.effectiveSignupDate, equals(signup.id.dateTime));
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        final signupDate = DateTime(2024, 1, 15, 10, 30);
        final objectId = ObjectId();
        final signup = NewsletterSignupModel(
          id: objectId,
          contactInfo: 'test@example.com',
          signupDate: signupDate,
          isActive: false,
        );

        final json = signup.toJson();

        expect(json['_id'], equals(objectId.oid));
        expect(json['contactInfo'], equals('test@example.com'));
        expect(json['signupDate'], equals(signupDate.toIso8601String()));
        expect(json['isActive'], isFalse);
      });

      test('should serialize with minimal fields', () {
        final signup = NewsletterSignupModel(
          contactInfo: 'minimal@example.com',
        );

        final json = signup.toJson();

        expect(json['contactInfo'], equals('minimal@example.com'));
        expect(json['isActive'], isTrue);
        expect(json.containsKey('signupDate'), isFalse);
      });

      test('should deserialize from JSON correctly', () {
        final objectId = ObjectId();
        final signupDate = DateTime(2024, 1, 15, 10, 30);
        final json = {
          '_id': objectId.oid,
          'contactInfo': 'test@example.com',
          'signupDate': signupDate.toIso8601String(),
          'isActive': false,
        };

        final signup = NewsletterSignupModel.fromJson(json);

        expect(signup.id.oid, equals(objectId.oid));
        expect(signup.contactInfo, equals('test@example.com'));
        expect(signup.signupDate, equals(signupDate));
        expect(signup.isActive, isFalse);
      });

      test('should deserialize with minimal fields and defaults', () {
        final json = {
          'contactInfo': 'minimal@example.com',
        };

        final signup = NewsletterSignupModel.fromJson(json);

        expect(signup.contactInfo, equals('minimal@example.com'));
        expect(signup.isActive, isTrue);
        expect(signup.signupDate, isNull);
        expect(signup.id, isA<ObjectId>());
      });
    });

    group('Database Serialization', () {
      test('should specify correct ObjectId fields', () {
        final signup = NewsletterSignupModel(
          contactInfo: 'test@example.com',
        );

        expect(signup.objectIdFields, equals({'_id'}));
      });

      test('should convert to database format preserving ObjectId', () {
        final objectId = ObjectId();
        final signup = NewsletterSignupModel(
          id: objectId,
          contactInfo: 'database@example.com',
          isActive: false,
        );

        final dbDoc = signup.toDatabase();

        expect(dbDoc['_id'], isA<ObjectId>());
        expect(dbDoc['_id'], equals(objectId));
        expect(dbDoc['contactInfo'], equals('database@example.com'));
        expect(dbDoc['isActive'], isFalse);
      });

      test('should handle round-trip through database format', () {
        final originalSignup = NewsletterSignupModel(
          contactInfo: 'roundtrip@example.com',
          signupDate: DateTime(2024, 1, 15),
          isActive: false,
        );

        // Convert to database format
        final dbDoc = originalSignup.toDatabase();

        // Convert back to JSON format (simulating database retrieval)
        final jsonDoc = Map<String, dynamic>.from(dbDoc);
        jsonDoc['_id'] = (jsonDoc['_id'] as ObjectId).oid;

        // Deserialize back to model
        final restoredSignup = NewsletterSignupModel.fromJson(jsonDoc);

        expect(restoredSignup.contactInfo, equals(originalSignup.contactInfo));
        expect(restoredSignup.signupDate, equals(originalSignup.signupDate));
        expect(restoredSignup.isActive, equals(originalSignup.isActive));
        expect(restoredSignup.id.oid, equals(originalSignup.id.oid));
      });
    });
  });
}
