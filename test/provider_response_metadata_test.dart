import 'dart:convert';
import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('recursive provider redaction retains useful unknown data and codes',
      () {
    final safe = redactProviderResponse({
      'client_secret': 'secret-value',
      'authorization': 'Bearer credential',
      'code': 'ORDER-42',
      'response': {
        'responseCode': '00',
        'approvalCode': '123456',
        'pan': '4111111111111111',
        'pinBlock': 'blocked',
        'track2': 'blocked',
        'purchaseAnalysisData': {'UCI': 'opaque-ref'},
        'nested': [
          {
            'cvv': '123',
            'transactionToken': 'reference',
            'access_token': 'blocked'
          }
        ]
      },
      'card': {'number': '4242424242424242', 'brand': 'visa'},
      'novel': {'carrierAdjustment': 3.2}
    }, provider: 'linkly') as Map;
    expect(safe['code'], 'ORDER-42');
    expect(safe['response']['approvalCode'], '123456');
    expect(safe['response']['pan'], '************1111');
    expect(safe['card']['number'], '************4242');
    expect(jsonEncode(safe), isNot(contains('blocked')));
    expect(safe.containsKey('client_secret'), isFalse);
    expect(safe['response']['nested'][0]['transactionToken'], 'reference');
    expect(safe['novel']['carrierAdjustment'], 3.2);
  });
  test('Linkly receipt text masks PAN but preserves useful references', () {
    final safe = redactProviderResponse({
      'receiptText': ['CARD 4111 1111 1111 1111', 'Approval 123456'],
      'token': 'reference',
      'code': '00'
    }, provider: 'linkly') as Map;
    expect(safe['receiptText'], ['CARD ************1111', 'Approval 123456']);
    expect(safe['token'], 'reference');
  });
  test('dedup ignores timestamp and key order but retains changed responses',
      () {
    final m = <String, dynamic>{};
    final a = providerResponseRecord(
        provider: 'stripe',
        operation: 'confirm',
        operationId: 'pi_test',
        response: {'status': 'pending', 'amount': 1100});
    appendProviderResponse(m, a);
    appendProviderResponse(
        m,
        providerResponseRecord(
            provider: 'stripe',
            operation: 'confirm',
            operationId: 'pi_test',
            response: {'amount': 1100, 'status': 'pending'}));
    appendProviderResponse(
        m,
        providerResponseRecord(
            provider: 'stripe',
            operation: 'confirm',
            operationId: 'pi_test',
            response: {'status': 'succeeded', 'amount': 1100}));
    expect(m['providerResponses'], hasLength(2));
    expect(SaleModel.fromJson(SaleModel(metadata: m).toJson()).metadata, m);
    expect(
        OrderModel.fromJson(OrderModel(
                    customerId: null,
                    items: {},
                    orderNumber: 'T',
                    paymentMethod: null,
                    metadata: m)
                .toJson())
            .metadata,
        m);
  });
  test('merging stale clients never drops existing provider evidence', () {
    final old = <String, dynamic>{};
    appendProviderResponse(
        old,
        providerResponseRecord(
            provider: 'linkly',
            operation: 'payment',
            response: {'success': false}));
    final fresh = <String, dynamic>{};
    appendProviderResponse(
        fresh,
        providerResponseRecord(
            provider: 'linkly',
            operation: 'payment',
            response: {'success': true}));
    expect(
        mergeProviderMetadata(old, fresh)['providerResponses'], hasLength(2));
    expect(mergeProviderMetadata(old, {})['providerResponses'], hasLength(1));
  });
  test('response bodies retain binary JSON and long values for archival', () {
    final safe = redactProviderResponse(
        {'labelData': 'synthetic pdf', 'large': 'x' * 70000, 'rate': 12},
        provider: 'starshipit') as Map;
    expect(safe['labelData'], 'synthetic pdf');
    expect(safe['large'], hasLength(70000));
    expect(safe['rate'], 12);
  });
}
