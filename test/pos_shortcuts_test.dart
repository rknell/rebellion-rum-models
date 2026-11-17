import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> fixture() => {
        'revision': 0,
        'groups': <dynamic>[
          <String, dynamic>{
            'id': 'flavours',
            'name': 'Flavours',
            'key': 'F',
            'enabled': true,
            'options': <dynamic>[
              <String, dynamic>{
                'key': 'B',
                'label': 'Blue',
                'productId': '0123456789abcdef01234567',
                'enabled': true
              }
            ]
          }
        ]
      };
  test('normalizes keys and round trips ordered explicit product selections',
      () {
    final config = PosShortcutConfiguration.fromJson(fixture());
    expect(config.groups.single.key, 'f');
    expect(config.groups.single.options.single.key, 'b');
    expect(PosShortcutConfiguration.fromJson(config.toJson()).toJson(),
        config.toJson());
  });
  test('empty configuration is an explicit clear', () {
    expect(
        PosShortcutConfiguration.fromJson(
            <String, dynamic>{'revision': 2, 'groups': <dynamic>[]}).groups,
        isEmpty);
  });
  test('rejects malformed persisted fields before casts', () {
    for (final bad in [null, '1', -1, 1.5, double.nan]) {
      expect(
          () =>
              PosShortcutConfiguration.fromJson(fixture()..['revision'] = bad),
          throwsFormatException);
    }
    for (final bad in [null, <String, dynamic>{}, 'groups']) {
      expect(
          () => PosShortcutConfiguration.fromJson(fixture()..['groups'] = bad),
          throwsFormatException);
    }
    for (final key in ['', 'enter', '?']) {
      final json = fixture();
      (json['groups'] as List).first['key'] = key;
      expect(
          () => PosShortcutConfiguration.fromJson(json), throwsFormatException);
    }
    final invalid = fixture();
    (invalid['groups'] as List).first['enabled'] = 'true';
    expect(() => PosShortcutConfiguration.fromJson(invalid),
        throwsFormatException);
    final missingProduct = fixture();
    (missingProduct['groups'] as List).first['options'][0]['productId'] = null;
    expect(() => PosShortcutConfiguration.fromJson(missingProduct),
        throwsFormatException);
  });
  test('rejects duplicate enabled keys and permits disabled unassigned options',
      () {
    final json = fixture();
    final group = (json['groups'] as List).first;
    group['options'].add(Map<String, dynamic>.from(group['options'][0]));
    expect(
        () => PosShortcutConfiguration.fromJson(json), throwsFormatException);
    group['options'][1]['enabled'] = false;
    group['options'][1]['productId'] = null;
    expect(PosShortcutConfiguration.fromJson(json).groups.single.options,
        hasLength(2));
  });
  test('catalogue conflict validation checks direct keys and active products',
      () {
    final config = PosShortcutConfiguration.fromJson(fixture());
    final product = ProductModel.fromJson({
      '_id': '0123456789abcdef01234567',
      'name': 'Blue',
      'barcode': 'blue',
      'shortcut': 'f'
    });
    expect(() => config.validateProducts([product]), throwsFormatException);
    product.shortcut = null;
    config.validateProducts([product]);
    product.isArchived = true;
    expect(() => config.validateProducts([product]), throwsFormatException);
  });
}
