import 'dart:convert';
import 'package:test/test.dart';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';

void main() {
  group('StripeConfirmPaymentIntentResponse', () {
    // The exact JSON string provided for testing
    const jsonString = '''
{
  "id": "pi_3MtweELkdIwHu7ix0Dt0gF2H",
  "object": "payment_intent",
  "amount": 2000,
  "amount_capturable": 0,
  "amount_details": {
    "tip": {}
  },
  "amount_received": 2000,
  "application": null,
  "application_fee_amount": null,
  "automatic_payment_methods": {
    "enabled": true
  },
  "canceled_at": null,
  "cancellation_reason": null,
  "capture_method": "automatic",
  "client_secret": "pi_3MtweELkdIwHu7ix0Dt0gF2H_secret_ALlpPMIZse0ac8YzPxkMkFgGC",
  "confirmation_method": "automatic",
  "created": 1680802258,
  "currency": "usd",
  "customer": null,
  "description": null,
  "last_payment_error": null,
  "latest_charge": "ch_3MtweELkdIwHu7ix05lnLAFd",
  "livemode": false,
  "metadata": {},
  "next_action": null,
  "on_behalf_of": null,
  "payment_method": "pm_1MtweELkdIwHu7ixxrsejPtG",
  "payment_method_options": {
    "card": {
      "installments": null,
      "mandate_options": null,
      "network": null,
      "request_three_d_secure": "automatic"
    },
    "link": {
      "persistent_token": null
    }
  },
  "payment_method_types": [
    "card",
    "link"
  ],
  "processing": null,
  "receipt_email": null,
  "review": null,
  "setup_future_usage": null,
  "shipping": null,
  "source": null,
  "statement_descriptor": null,
  "statement_descriptor_suffix": null,
  "status": "succeeded",
  "transfer_data": null,
  "transfer_group": null
}
''';

    test('should deserialize from JSON correctly', () {
      // Parse the JSON string
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

      // Create the response model from JSON
      final response = StripeConfirmPaymentIntentResponse.fromJson(jsonMap);

      // Verify basic properties
      expect(response, isNotNull);
      expect(response.id, equals('pi_3MtweELkdIwHu7ix0Dt0gF2H'));
      expect(response.object, equals('payment_intent'));
      expect(response.amount, equals(2000));
      expect(response.amountCapturable, equals(0));
      expect(response.amountReceived, equals(2000));
      expect(response.captureMethod, equals('automatic'));
      expect(
          response.clientSecret,
          equals(
              'pi_3MtweELkdIwHu7ix0Dt0gF2H_secret_ALlpPMIZse0ac8YzPxkMkFgGC'));
      expect(response.confirmationMethod, equals('automatic'));
      expect(response.created, equals(1680802258));
      expect(response.currency, equals('usd'));
      expect(response.livemode, equals(false));
      expect(response.latestCharge, equals('ch_3MtweELkdIwHu7ix05lnLAFd'));
      expect(response.paymentMethod, equals('pm_1MtweELkdIwHu7ixxrsejPtG'));
      expect(response.status, equals('succeeded'));

      // Verify nested properties
      expect(response.amountDetails, isNotNull);
      expect(response.amountDetails!.containsKey('tip'), isTrue);

      expect(response.automaticPaymentMethods, isNotNull);
      expect(response.automaticPaymentMethods!['enabled'], isTrue);

      expect(response.paymentMethodOptions, isNotNull);
      expect(response.paymentMethodOptions!.containsKey('card'), isTrue);
      expect(response.paymentMethodOptions!.containsKey('link'), isTrue);

      expect(response.paymentMethodTypes, isNotNull);
      expect(response.paymentMethodTypes!.length, equals(2));
      expect(response.paymentMethodTypes![0], equals('card'));
      expect(response.paymentMethodTypes![1], equals('link'));

      // Verify null fields
      expect(response.application, isNull);
      expect(response.applicationFeeAmount, isNull);
      expect(response.canceledAt, isNull);
      expect(response.cancellationReason, isNull);
      expect(response.customer, isNull);
      expect(response.description, isNull);
      expect(response.lastPaymentError, isNull);
      expect(response.nextAction, isNull);
      expect(response.onBehalfOf, isNull);
      expect(response.processing, isNull);
      expect(response.receiptEmail, isNull);
      expect(response.review, isNull);
      expect(response.setupFutureUsage, isNull);
      expect(response.shipping, isNull);
      expect(response.source, isNull);
      expect(response.statementDescriptor, isNull);
      expect(response.statementDescriptorSuffix, isNull);
      expect(response.transferData, isNull);
      expect(response.transferGroup, isNull);
    });

    test('should serialize to JSON correctly', () {
      // Parse the original JSON string
      final originalJsonMap = json.decode(jsonString) as Map<String, dynamic>;

      // Create the response model from JSON
      final response =
          StripeConfirmPaymentIntentResponse.fromJson(originalJsonMap);

      // Serialize back to JSON
      final serializedJsonMap = response.toJson();

      // Verify that key properties match after a round trip
      expect(serializedJsonMap['id'], equals(originalJsonMap['id']));
      expect(serializedJsonMap['object'], equals(originalJsonMap['object']));
      expect(serializedJsonMap['amount'], equals(originalJsonMap['amount']));
      expect(serializedJsonMap['amount_capturable'],
          equals(originalJsonMap['amount_capturable']));
      expect(serializedJsonMap['amount_received'],
          equals(originalJsonMap['amount_received']));
      expect(serializedJsonMap['capture_method'],
          equals(originalJsonMap['capture_method']));
      expect(serializedJsonMap['client_secret'],
          equals(originalJsonMap['client_secret']));
      expect(serializedJsonMap['confirmation_method'],
          equals(originalJsonMap['confirmation_method']));
      expect(serializedJsonMap['created'], equals(originalJsonMap['created']));
      expect(
          serializedJsonMap['currency'], equals(originalJsonMap['currency']));
      expect(
          serializedJsonMap['livemode'], equals(originalJsonMap['livemode']));
      expect(serializedJsonMap['payment_method'],
          equals(originalJsonMap['payment_method']));
      expect(serializedJsonMap['status'], equals(originalJsonMap['status']));

      // Verify arrays and nested objects
      expect(serializedJsonMap['payment_method_types'],
          unorderedEquals(originalJsonMap['payment_method_types']));

      // Ensure payment_method_options contain the same keys
      expect(serializedJsonMap['payment_method_options']?.keys,
          unorderedEquals(originalJsonMap['payment_method_options']?.keys));
    });
  });
}
