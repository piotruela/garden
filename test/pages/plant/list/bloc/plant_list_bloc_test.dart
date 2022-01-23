import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_state.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'plant_list_bloc_test.mocks.dart';

final plants = [
  Plant(id: '1', name: 'name1', type: PlantType.grasses, plantingDate: DateTime(2022)),
  Plant(id: '2', name: 'name2', type: PlantType.succulents, plantingDate: DateTime(2021)),
  Plant(id: '3', name: 'name3', type: PlantType.trees, plantingDate: DateTime(2020)),
  Plant(id: '4', name: 'name4', type: PlantType.ferns, plantingDate: DateTime(2019)),
  Plant(id: '5', name: 'name5', type: PlantType.alpines, plantingDate: DateTime(2018)),
  Plant(id: '6', name: 'name6', type: PlantType.bulbs, plantingDate: DateTime(2017)),
  Plant(id: '7', name: 'name7', type: PlantType.climbers, plantingDate: DateTime(2016)),
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
    plantListBloc = PlantListBloc(onMoveToUpsertPagePressed: (_) async => null);
    reset(mockPlantService);
  });

  group('initial event', () {
    test('should have initial state after creation', () {
      expect(plantListBloc.state, PlantListState.initial());
    });

    test('should invoke getPlants() method with offset 0 on initial event', () async {
      when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));

      plantListBloc.add(InitializePage());
      await Future.delayed(const Duration(milliseconds: 300));

      verify(mockPlantService.getPlants(offset: 0)).called(1);
    });

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchedData] states for'
      'successful plants fetch',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => const Right([]));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
      },
      expect: () => <PlantListState>[PlantListState.inProgress(), PlantListState.fetchedData()],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchingError] states for'
      'unsuccessful plants fetch',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Left(DatabaseFailure()));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
      },
      expect: () => <PlantListState>[PlantListState.inProgress(), PlantListState.fetchingError()],
    );
  });

  group('search text changed event', () {
    test('should invoke getPlants() with given search text', () async {
      when(mockPlantService.getPlants(offset: 0, searchText: '123')).thenAnswer((_) async => const Right([]));

      plantListBloc.add(const SearchTextChanged('123'));
      await Future.delayed(const Duration(milliseconds: 300));

      verify(mockPlantService.getPlants(offset: 0, searchText: '123')).called(1);
    });

    test('should not pass search text to getPlants() when it is empty', () async {
      when(mockPlantService.getPlants(offset: 0, searchText: null)).thenAnswer((_) async => const Right([]));

      plantListBloc.add(const SearchTextChanged(''));
      await Future.delayed(const Duration(milliseconds: 300));

      verifyNever(mockPlantService.getPlants(offset: 0, searchText: ''));
      verify(mockPlantService.getPlants(offset: 0, searchText: null)).called(1);
    });

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchedData] states for'
      'successful plants search',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0, searchText: '123')).thenAnswer((_) async => const Right([]));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(const SearchTextChanged('123'));
      },
      expect: () => <PlantListState>[PlantListState.inProgress(), PlantListState.fetchedData(searchText: '123')],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchingError] states for'
      'unsuccessful plants search',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0, searchText: '123')).thenAnswer((_) async => Left(DatabaseFailure()));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(const SearchTextChanged('123'));
      },
      expect: () => <PlantListState>[PlantListState.inProgress(), PlantListState.fetchingError(searchText: '123')],
    );
  });

  group('threshold reached event', () {
    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchedData, PlantListState.fetchedData] states',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants.take(5).toList()));
        when(mockPlantService.getPlants(offset: 5)).thenAnswer((_) async => Right(plants.skip(5).toList()));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
        bloc.add(const ThresholdReached());
      },
      expect: () => <PlantListState>[
        PlantListState.inProgress(),
        PlantListState.fetchedData(plants: plants.take(5).toList()),
        PlantListState.fetchedData(plants: plants),
      ],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress, PlantListState.fetchedData, PlantListState.reachedEnd] states'
      'when full plants list is already fetched',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants));
        when(mockPlantService.getPlants(offset: plants.length)).thenAnswer((_) async => const Right([]));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
        bloc.add(const ThresholdReached());
      },
      expect: () => <PlantListState>[
        PlantListState.inProgress(),
        PlantListState.fetchedData(plants: plants),
        PlantListState.reachedEnd(plants: plants),
      ],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should not emit any new states when current state is PlantListState.reachedEnd',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants));
        when(mockPlantService.getPlants(offset: plants.length)).thenAnswer((_) async => const Right([]));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
        bloc.add(const ThresholdReached());
        bloc.add(const ThresholdReached());
        bloc.add(const ThresholdReached());
      },
      expect: () => <PlantListState>[
        PlantListState.inProgress(),
        PlantListState.fetchedData(plants: plants),
        PlantListState.reachedEnd(plants: plants),
      ],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.inProgress PlantListState.fetchedData, PlantListState.fetchingError]'
      'when error occurs',
      setUp: () {
        when(mockPlantService.getPlants(offset: 0)).thenAnswer((_) async => Right(plants));
        when(mockPlantService.getPlants(offset: plants.length)).thenAnswer((_) async => Left(DatabaseFailure()));
      },
      build: () => plantListBloc,
      act: (bloc) {
        bloc.add(InitializePage());
        bloc.add(const ThresholdReached());
      },
      expect: () => <PlantListState>[
        PlantListState.inProgress(),
        PlantListState.fetchedData(plants: plants),
        PlantListState.fetchingError(plants: plants),
      ],
    );
  });

  group('move to upsert page event', () {
    blocTest<PlantListBloc, PlantListState>(
      'should not emit any event when upsert result is null',
      build: () => plantListBloc,
      act: (bloc) => bloc.add(const MoveToUpsertPage()),
      expect: () => <PlantListState>[],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.upsertSuccess] with type insert'
      'when event does not contain existing plant, and upsert succeeded',
      build: () => PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first)),
      act: (bloc) => bloc.add(const MoveToUpsertPage()),
      expect: () => <PlantListState>[
        PlantListState.upsertSuccess(plant: plants.first, upsertType: UpsertType.insert),
      ],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.upsertSuccess] with type update'
      'when event contains existing plant, and upsert succeeded',
      build: () => PlantListBloc(onMoveToUpsertPagePressed: (_) async => Right(plants.first)),
      act: (bloc) => bloc.add(MoveToUpsertPage(existingPlant: plants.first)),
      expect: () => <PlantListState>[
        PlantListState.upsertSuccess(plant: plants.first, upsertType: UpsertType.update),
      ],
    );

    blocTest<PlantListBloc, PlantListState>(
      'should emit [PlantListState.upsertError]'
      'when upsert not succeeded',
      build: () => PlantListBloc(onMoveToUpsertPagePressed: (_) async => Left(DatabaseFailure())),
      act: (bloc) => bloc.add(const MoveToUpsertPage()),
      expect: () => <PlantListState>[
        PlantListState.upsertError(),
      ],
    );
  });
}
