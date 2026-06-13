import 'package:mongo_dart/mongo_dart.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('Mailing list models', () {
    test('serializes one contact with multiple list memberships', () {
      final contactId = ObjectId();
      final contact = MailingContactModel(
        id: contactId,
        email: 'Customer@Example.com',
        normalizedEmail: 'customer@example.com',
        normalizedPhone: '',
        displayContact: 'customer@example.com',
        source: 'newsletter',
      );
      final newsletter = MailingListMembershipModel(
        contactId: contactId,
        listKey: 'newsletter',
        source: 'newsletter-form',
      );
      final stock = MailingListMembershipModel(
        contactId: contactId,
        listKey: 'product-stock-american-oak',
        source: 'stock-reminder',
      );

      expect(contact.toJson()['normalizedEmail'], equals('customer@example.com'));
      expect(newsletter.toJson()['contactId'], equals(contactId.oid));
      expect(stock.toJson()['contactId'], equals(contactId.oid));
      expect(newsletter.toJson()['listKey'], equals('newsletter'));
      expect(stock.toJson()['listKey'], equals('product-stock-american-oak'));
    });

    test('serializes archive batches and send logs', () {
      final batch = MailingArchiveBatchModel(
        batchId: 'newsletter-2026-06-13T000000Z',
        listKey: 'newsletter',
        listName: 'Newsletter',
        memberCount: 12,
      );
      final send = MailingSendModel(
        listKey: 'newsletter',
        archiveBatchId: batch.batchId,
        subject: 'Back in stock',
        htmlBody: '<p>Hello</p>',
        textBody: 'Hello',
        smsBody: 'Hello',
        emailedCount: 8,
        skippedPhoneOnlyCount: 4,
        skippedPhones: ['0400000000'],
      );

      expect(batch.toJson()['memberCount'], equals(12));
      expect(send.toJson()['archiveBatchId'], equals(batch.batchId));
      expect(send.toJson()['skippedPhones'], equals(['0400000000']));
    });
  });
}
