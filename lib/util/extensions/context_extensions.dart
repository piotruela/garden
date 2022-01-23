import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  void unFocus() => FocusScope.of(this).unfocus();
}
