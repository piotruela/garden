import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/plant_type_label.dart';
import 'package:garden/common/widget/rounded_button.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/view/plant_upsert_view.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_date_field.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_name_field.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_widget.dart';
import 'plant_upsert_view_test.mocks.dart';

final plant = Plant(id: '1', name: 'name', type: PlantType.alpines, plantingDate: DateTime(2022));

@GenerateMocks([PlantService])
void main() {
  late PlantUpsertBloc plantUpsertBloc;
  late PlantService mockPlantService;

  setUpAll(() {
    mockPlantService = MockPlantService();
    GetIt.instance.registerSingleton<PlantService>(mockPlantService);
  });

  tearDownAll(() {
    GetIt.I.unregister<PlantService>(instance: mockPlantService);
  });

  group('adding plant', () {
    testWidgets('should have appbar with right title and button', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      final appBarTitleFinder = find.text('Add plant');
      final appBarActionButtonFinder = find.widgetWithText(RoundedButton, "Save");

      expect(appBarTitleFinder, findsOneWidget);
      expect(appBarActionButtonFinder, findsOneWidget);
    });

    testWidgets('should have all fields', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      final nameFieldLabelFinder = find.text('Name');
      final nameFieldFinder = find.byType(PlantUpsertNameField);
      final typeFieldLabelFinder = find.text('Plant type');
      final typeFieldFinder = find.byType(PlantTypeLabel, skipOffstage: false);
      final dateFieldLabelFinder = find.text('Planting date');
      final dateFieldFinder = find.byType(PlantUpsertDateField);

      expect(nameFieldLabelFinder, findsOneWidget);
      expect(nameFieldFinder, findsOneWidget);
      expect(typeFieldLabelFinder, findsOneWidget);
      expect(typeFieldFinder, findsNWidgets(9));
      expect(dateFieldLabelFinder, findsOneWidget);
      expect(dateFieldFinder, findsOneWidget);
    });

    testWidgets('should have disabled action button when required fields are empty', (WidgetTester tester) async {
      bool pressed = false;
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => pressed = true);
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.widgetWithText(RoundedButton, "Save"));

      expect(pressed, false);
    });

    testWidgets('should allow to write to name field', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(PlantUpsertNameField), '123');
      final insertedTextFinder = find.text('123');

      expect(insertedTextFinder, findsOneWidget);
    });

    testWidgets('should update name field in state when text is entered to name field', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(PlantUpsertNameField), '123');

      expect(plantUpsertBloc.state.plantName, '123');
    });

    testWidgets('should change selected plant type on plant type label press', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.widgetWithText(PlantTypeLabel, 'Alpines'));
      expect(plantUpsertBloc.state.plantType, PlantType.alpines);
      await tester.tap(find.widgetWithText(PlantTypeLabel, 'Bulbs'));
      expect(plantUpsertBloc.state.plantType, PlantType.bulbs);
    });

    testWidgets('should enable save button when all fields are filled', (WidgetTester tester) async {
      bool pressed = false;
      final now = DateTime.now();
      final currentDayDate = DateTime(now.year, now.month, now.day);
      final plant = Plant(name: '123', type: PlantType.alpines, plantingDate: currentDayDate);
      when(mockPlantService.insertPlant(plant)).thenAnswer((_) async => Right(plant));
      final plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (_) => pressed = true);
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: false),
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.widgetWithText(RoundedButton, "Save"));

      expect(pressed, false);

      await tester.enterText(find.byType(PlantUpsertNameField), '123');
      await tester.tap(find.widgetWithText(PlantTypeLabel, 'Alpines'));
      await tester.tap(find.byType(PlantUpsertDateField));
      await tester.pumpAndSettle();
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(RoundedButton, "Save"));

      expect(pressed, true);
    });
  });

  group('updating plant', () {
    testWidgets('should have appbar with right title when page is in edit mode', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(existingPlant: plant, onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: true),
          ),
        ),
      );
      await tester.pump();

      final appBarTitleFinder = find.text('Update plant');

      expect(appBarTitleFinder, findsOneWidget);
    });

    testWidgets('should fill ale fields with data from passed plant', (WidgetTester tester) async {
      final plantUpsertBloc = PlantUpsertBloc(existingPlant: plant, onPlantInserted: (_) => {});
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantUpsertBloc>(
            create: (context) => plantUpsertBloc,
            child: const PlantUpsertView(isEdit: true),
          ),
        ),
      );
      await tester.pump();

      final nameFinder = find.text(plant.name);
      final plantLabel = tester.firstWidget(find.byType(PlantTypeLabel)) as PlantTypeLabel;
      final dateFinder = find.text(DateFormat("dd/MM/yyyy").format(plant.plantingDate));

      expect(nameFinder, findsOneWidget);
      expect(plantLabel.isSelected, true);
      expect(dateFinder, findsOneWidget);
    });
  });
}
