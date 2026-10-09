import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('legacy sales have independent empty metadata maps', () {
    final first = SaleModel.fromJson({});
    final second = SaleModel.fromJson({'metadata': null});
    first.metadata['source'] = 'test';
    expect(second.metadata, isEmpty);
  });

  test('nested transaction metadata survives serialization', () {
    final metadata = <String, dynamic>{
      'otherFeature': {'enabled': true},
      'linklyTransactions': {
        'session-1': {
          'responseJson': {
            'response': {
              'success': true,
              'purchaseAnalysisData': {'UCI': 'opaque-card-id'},
            },
          },
        },
      },
    };
    final sale = SaleModel(metadata: metadata);
    expect(SaleModel.fromJson(sale.toJson()).metadata, metadata);
  });
}
