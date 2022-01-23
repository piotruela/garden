import 'package:flutter/material.dart';

class UnFocusOnTap extends StatelessWidget {
  final Widget child;

  const UnFocusOnTap({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
