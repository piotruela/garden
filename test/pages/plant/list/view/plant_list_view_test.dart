import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/common/widget/rounded_button.dart';
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/view/plant_list_view.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_app_bar_search_field.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_body.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_list_tile.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_widget.dart';
import 'plant_list_view_test.mocks.dart';

final plants = [
  Plant(id: '1', name: 'name1', type: PlantType.grasses, plantingDate: DateTime(2022)),
  Plant(id: '2', name: 'name2', type: PlantType.succulents, plantingDate: DateTime(2021)),
  Plant(id: '3', name: 'name3', type: PlantType.trees, plantingDate: DateTime(2020)),
  Plant(id: '4', name: 'name4', type: PlantType.ferns, plantingDate: DateTime(2019)),
  Plant(id: '5', name: 'name5', type: PlantType.alpines, plantingDate: DateTime(2018)),
  Plant(id: '6', name: 'name6', type: PlantType.bulbs, plantingDate: DateTime(2017)),
  Plant(id: '7', name: 'name7', type: PlantType.climbers, plantingDate: DateTime(2016)),
  Plant(id: '8', name: 'name8', type: PlantType.ferns, plantingDate: DateTime(2015)),
  Plant(id: '9', name: 'name9', type: PlantType.alpines, plantingDate: DateTime(2014)),
  Plant(id: '10', name: 'name10', type: PlantType.bulbs, plantingDate: DateTime(2013)),
  Plant(id: '11', name: 'name11', type: PlantType.climbers, plantingDate: DateTime(2012)),
];

@GenerateMocks([PlantService])
void main() {
  late PlantListBloc plantListBloc;
  late PlantService mockPlantService;

  setUpAll(() {
    mockPlantService = MockPlantService();
    GetIt.instance.registerSingleton<PlantService>(mockPlantService);
  });

  tearDownAll(() {
    GetIt.I.unregister<PlantService>(instance: mockPlantService);
  });

  setUp(() {
    reset(mockPlantService);
  });

  group('appbar', () {
    testWidgets('should have appbar with title button and searchbar', (WidgetTester tester) async {
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc,
            child: const PlantListView(),
          ),
        ),
      );
      await tester.pump();

      final appBarTitleFinder = find.text('Garden');
      final appBarActionButtonFinder = find.widgetWithText(RoundedButton, "+ Add plant");
      final appBarSearchBarFinder = find.byType(PlantListAppBarSearchField);

      expect(appBarTitleFinder, findsOneWidget);
      expect(appBarActionButtonFinder, findsOneWidget);
      expect(appBarSearchBarFinder, findsOneWidget);
    });

    testWidgets('searchbar should allow to write to it', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      when(mockPlantService.getPlants(offset: 0, searchText: '123')).thenAnswer((_) async => const Right([]));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc,
            child: const PlantListView(),
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(PlantListAppBarSearchField), '123');

      expect(find.text('123'), findsOneWidget);
    });

    testWidgets('appbar action button should invoke method passed to bloc', (WidgetTester tester) async {
      bool pressed = false;
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async {
        pressed = true;
        return Right(plants.first);
      });
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc,
            child: const PlantListView(),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.widgetWithText(RoundedButton, '+ Add plant'));
      await tester.pump();

      expect(pressed, true);
    });
  });

  group('reacting to fetch result', () {
    testWidgets('should show loader while plants are being fetched', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async {
        Future.delayed(const Duration(seconds: 1));
        return const Right([]);
      });
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      final loaderFinder = find.byType(SpinKitThreeBounce);
      expect(loaderFinder, findsOneWidget);

      await tester.pump(const Duration(seconds: 2));

      expect(loaderFinder, findsNothing);
    });

    testWidgets('should show no data widget when service returns empty list', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final emptyListWidgetFinder = find.byType(EmptyPlantListWidget);
      expect(emptyListWidgetFinder, findsOneWidget);
    });

    testWidgets('should show error widget when fetching fails', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Left(DatabaseFailure()));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final errorWidgetFinder = find.byType(PlantListErrorWidget);
      expect(errorWidgetFinder, findsOneWidget);
    });

    testWidgets('should display list of plants when fetching succeed', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants.take(5).toList()));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final listTilesFinder = find.byType(PlantListListTile, skipOffstage: false);
      expect(listTilesFinder, findsNWidgets(5));
    });
  });

  group('snack bars', () {
    testWidgets('should show right snack bar on plant added to database', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(RoundedButton, '+ Add plant'));
      await tester.pumpAndSettle();
      final snackBarTextFinder = find.text("Added ${plants.first.name} to your collection");

      expect(snackBarTextFinder, findsOneWidget);
    });

    testWidgets('should show right snack bar on database error', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => Left(DatabaseFailure()));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(RoundedButton, '+ Add plant'));
      await tester.pumpAndSettle();
      final snackBarTextFinder = find.text("There was an error");

      expect(snackBarTextFinder, findsOneWidget);
    });

    testWidgets('should show right snack bar on existing plant edited', (WidgetTester tester) async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants));
      plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (plant) async => Right(plant!));
      await tester.pumpWidget(
        TestWidget(
          child: BlocProvider<PlantListBloc>(
            create: (context) => plantListBloc..add(InitializePage()),
            child: const PlantListView(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(PlantListListTile, 'name1'));
      await tester.pumpAndSettle();
      final snackBarTextFinder = find.text("Successfully edited ${plants.first.name}");

      expect(snackBarTextFinder, findsOneWidget);
    });
  });
}
