import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/app_snack_bar.dart';
import 'package:garden/common/widget/rounded_button.dart';

import '../../test_widget.dart';

void main() {
  testWidgets('should show with text, when invoked', (WidgetTester tester) async {
    const snackBarText = 'SnackBar text';
    const tapTarget = Key('tap-target');

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return RoundedButton(
                key: tapTarget,
                label: 'Button',
                onPressed: () => AppSnackBar(content: const Text(snackBarText)).show(context),
              );
            },
          ),
        ),
      ),
    );

    expect(find.text(snackBarText), findsNothing);
    await tester.tap(find.byKey(tapTarget));
    await tester.pump();
    expect(find.text(snackBarText), findsOneWidget);
  });
}
