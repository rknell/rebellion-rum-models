import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  test('legacy runs have no label range', () {
    final json = PackagingRunItemModel().toJson()
      ..remove('labelNumberStart')
      ..remove('labelNumberEnd');
    final model = PackagingRunItemModel.fromJson(json);
    expect(model.labelNumberStart, isNull);
    expect(model.labelNumberEnd, isNull);
  });

  test('inclusive label range survives serialization', () {
    final model = PackagingRunItemModel(
      labelNumberStart: 1,
      labelNumberEnd: 150,
    );
    final restored = PackagingRunItemModel.fromJson(model.toJson());
    expect(restored.labelNumberStart, 1);
    expect(restored.labelNumberEnd, 150);
  });
}
