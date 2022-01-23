import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color lighten([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
