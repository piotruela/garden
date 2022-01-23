import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/plant_type_label.dart';
import 'package:garden/extensions.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_list_tile.dart';
import 'package:intl/intl.dart';

import '../../../../../test_widget.dart';

void main() {
  testWidgets('should display all information', (WidgetTester tester) async {
    final plant = Plant(id: '1', name: 'name', type: PlantType.bulbs, plantingDate: DateTime(2022, 01, 10));

    await tester.pumpWidget(
      TestWidget(
        child: Scaffold(
          body: PlantListListTile(
            plant: plant,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final nameFinder = find.text(plant.name);
    final typeLabelFinder = find.widgetWithText(PlantTypeLabel, describeEnum(plant.type).capitalize());
    final plantingDateFinder = find.text("Planted at ${DateFormat.yMd().format(plant.plantingDate)}");
    final avatarFinder = find.widgetWithText(FittedBox, "NE");

    expect(nameFinder, findsOneWidget);
    expect(typeLabelFinder, findsOneWidget);
    expect(plantingDateFinder, findsOneWidget);
    expect(avatarFinder, findsOneWidget);
  });
}
