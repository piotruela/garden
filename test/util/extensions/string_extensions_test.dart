import 'package:flutter_test/flutter_test.dart';
import 'package:garden/extensions.dart';

void main() {
  test('should uppercase first letter and lowercase rest', () {
    const lowercaseString = 'string';

    final capitalizedString = lowercaseString.capitalize();

    expect(capitalizedString, "String");
  });
}
