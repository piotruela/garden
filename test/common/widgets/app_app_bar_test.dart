import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/common/widget/rounded_button.dart';

import '../../test_widget.dart';

void main() {
  testWidgets('should render with title and button', (WidgetTester tester) async {
    const appBarTitle = 'Test title';
    const buttonLabel = 'Test button';

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          appBar: AppAppBar(
            title: appBarTitle,
            buttonLabel: buttonLabel,
            onActionButtonPressed: () {},
          ),
        ),
      ),
    );

    final titleFinder = find.text(appBarTitle);
    final buttonTextFinder = find.text(buttonLabel);

    expect(titleFinder, findsOneWidget);
    expect(buttonTextFinder, findsOneWidget);
  });

  testWidgets('should render with no overflow when texts are long', (WidgetTester tester) async {
    const appBarTitle = 'Test title Test title Test title Test title';
    const buttonLabel = 'Test button Test button Test button Test button';

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          appBar: AppAppBar(
            title: appBarTitle,
            buttonLabel: buttonLabel,
            onActionButtonPressed: () {},
          ),
        ),
      ),
    );

    final titleFinder = find.text(appBarTitle);
    final buttonTextFinder = find.text(buttonLabel);

    expect(titleFinder, findsOneWidget);
    expect(buttonTextFinder, findsOneWidget);
  });

  testWidgets('should allow to interact with action button by default', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          appBar: AppAppBar(
            title: "Title",
            buttonLabel: "Button",
            onActionButtonPressed: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(RoundedButton, "Button"));

    expect(tapped, true);
  });

  testWidgets('should do nothing on button tapped, when button is inactive', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          appBar: AppAppBar(
            title: "Title",
            buttonLabel: "Button",
            onActionButtonPressed: () => tapped = true,
            isActionButtonActive: false,
          ),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(RoundedButton, "Button"));

    expect(tapped, false);
  });

  testWidgets('should have height of 70, when no bottom widget is passed', (WidgetTester tester) async {
    final appBar = AppAppBar(
      key: const Key("appBar"),
      title: "Title",
      buttonLabel: "Button",
      onActionButtonPressed: () {},
    );

    expect(appBar.preferredSize.height, 70);
  });

  testWidgets('should have height of 100, when bottom widget is passed', (WidgetTester tester) async {
    final appBar = AppAppBar(
      key: const Key("appBar"),
      title: "Title",
      buttonLabel: "Button",
      onActionButtonPressed: () {},
      bottom: const TabBar(tabs: []),
    );

    expect(appBar.preferredSize.height, 100);
  });
}
