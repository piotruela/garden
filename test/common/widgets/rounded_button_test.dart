import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/rounded_button.dart';

import '../../test_widget.dart';

void main() {
  testWidgets('should render with label', (WidgetTester tester) async {
    const buttonLabel = 'Button';

    await tester.pumpWidget(TestWidget(child: Scaffold(body: RoundedButton(label: buttonLabel, onPressed: () {}))));

    final widgetFinder = find.widgetWithText(RoundedButton, buttonLabel);

    expect(widgetFinder, findsOneWidget);
  });

  testWidgets('should react to tap, by default', (WidgetTester tester) async {
    const buttonLabel = 'Button';
    bool tapped = false;

    await tester.pumpWidget(
      TestWidget(child: Scaffold(body: RoundedButton(label: buttonLabel, onPressed: () => tapped = true))),
    );

    final widgetFinder = find.widgetWithText(RoundedButton, buttonLabel);
    await tester.tap(widgetFinder);
    await tester.pump();

    expect(tapped, true);
  });

  testWidgets('should not react to tap, when button is deactivated', (WidgetTester tester) async {
    const buttonLabel = 'Button';
    bool tapped = false;

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
            body: RoundedButton(
          label: buttonLabel,
          onPressed: () => tapped = true,
          isActive: false,
        )),
      ),
    );

    final widgetFinder = find.widgetWithText(RoundedButton, buttonLabel);
    await tester.tap(widgetFinder);
    await tester.pump();

    expect(tapped, false);
  });
}
