import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/plant_type_label.dart';
import 'package:garden/model/plant/type/plant_type.dart';

import '../../test_widget.dart';

void main() {
  testWidgets('should properly format PlantType value', (WidgetTester tester) async {
    const plantType = PlantType.grasses;

    await tester.pumpWidget(const TestWidget(child: Scaffold(body: PlantTypeLabel(type: plantType))));

    final labelTextFinder = find.text("Grasses");
    final wrongLabelTextFinder = find.text("grasses");

    expect(labelTextFinder, findsOneWidget);
    expect(wrongLabelTextFinder, findsNothing);
  });
}
