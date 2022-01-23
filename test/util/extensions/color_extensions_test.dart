import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/extensions.dart';

void main() {
  test('should lighten color by 0.1 by default', () {
    const initialColor = Color(0xff534985);

    final lightenedColor = initialColor.lighten();

    expect(lightenedColor, const Color(0xff685ca5));
  });

  test('should lighten color by passed arg number', () {
    const initialColor = Color(0xff534985);

    final lightenedColor = initialColor.lighten(0.5);

    expect(lightenedColor, const Color(0xffe2dfee));
  });
}
