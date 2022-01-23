import 'package:flutter_test/flutter_test.dart';
import 'package:garden/extensions.dart';

void main() {
  test('should separate list elements with arg', () {
    final list = [1, 2, 3, 4, 5];

    final listWithSeparator = list.separatedWith(0);

    expect(listWithSeparator[1], 0);
    expect(listWithSeparator[3], 0);
    expect(listWithSeparator[5], 0);
    expect(listWithSeparator[7], 0);
  });
}
