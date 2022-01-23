import 'package:flutter_test/flutter_test.dart';
import 'package:garden/extensions.dart';

void main() {
  test('should return null when predicate is false', () {
    const String string = '12345';

    final result = string.takeIf((it) => false);

    expect(result, null);
  });

  test('should return value when predicate is true', () {
    const String string = '12345';

    final result = string.takeIf((it) => true);

    expect(result, string);
  });
}
