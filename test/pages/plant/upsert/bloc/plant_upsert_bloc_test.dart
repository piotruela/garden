import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_state.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'plant_upsert_bloc_test.mocks.dart';

final plant = Plant(id: '1', name: 'name', type: PlantType.climbers, plantingDate: DateTime(2022));
final plantWithNoId = Plant(name: 'name', type: PlantType.climbers, plantingDate: DateTime(2022));

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

  setUp(() {
    plantUpsertBloc = PlantUpsertBloc(existingPlant: plant, onPlantInserted: (plant) async => Right(plant));
    reset(mockPlantService);
  });

  test('should set PlantUpsertState with all fields empty when no existing plant is passed', () {
    plantUpsertBloc = PlantUpsertBloc(onPlantInserted: (plant) async => Right(plant));

    expect(plantUpsertBloc.state.plantId, null);
    expect(plantUpsertBloc.state.plantName, null);
    expect(plantUpsertBloc.state.plantType, null);
    expect(plantUpsertBloc.state.plantingDate, null);
  });

  test('should set PlantUpsertState with all fields taken from passed existing plant', () {
    expect(plantUpsertBloc.state.plantId, plant.id);
    expect(plantUpsertBloc.state.plantName, plant.name);
    expect(plantUpsertBloc.state.plantType, plant.type);
    expect(plantUpsertBloc.state.plantingDate, plant.plantingDate);
  });

  blocTest<PlantUpsertBloc, PlantUpsertState>(
    'should change plantName on PlantNameChanged event',
    build: () => plantUpsertBloc,
    act: (bloc) {
      bloc.add(const PlantNameChanged('new-name'));
    },
    expect: () => <PlantUpsertState>[
      PlantUpsertState(
        plantId: plant.id,
        plantName: 'new-name',
        plantType: plant.type,
        plantingDate: plant.plantingDate,
      )
    ],
  );

  blocTest<PlantUpsertBloc, PlantUpsertState>(
    'should change plantType on PlantTypeSelected event',
    build: () => plantUpsertBloc,
    act: (bloc) {
      bloc.add(const PlantTypeSelected(PlantType.bulbs));
    },
    expect: () => <PlantUpsertState>[
      PlantUpsertState(
        plantId: plant.id,
        plantName: plant.name,
        plantType: PlantType.bulbs,
        plantingDate: plant.plantingDate,
      )
    ],
  );

  blocTest<PlantUpsertBloc, PlantUpsertState>(
    'should change plantingDate on PlantingDateChanged event',
    build: () => plantUpsertBloc,
    act: (bloc) {
      bloc.add(PlantingDateChanged(DateTime(2021)));
    },
    expect: () => <PlantUpsertState>[
      PlantUpsertState(
        plantId: plant.id,
        plantName: plant.name,
        plantType: plant.type,
        plantingDate: DateTime(2021),
      )
    ],
  );

  blocTest<PlantUpsertBloc, PlantUpsertState>(
    'should invoke updatePlant on SaveButtonPressed event when id field is not empty',
    setUp: () {
      when(mockPlantService.updatePlant(plant)).thenAnswer((_) async => Right(plant));
    },
    build: () => plantUpsertBloc,
    act: (bloc) {
      bloc.add(SaveButtonPressed());
    },
    expect: () {
      verify(mockPlantService.updatePlant(plant)).called(1);
      verifyNever(mockPlantService.insertPlant(plant));
      return <PlantUpsertState>[];
    },
  );

  blocTest<PlantUpsertBloc, PlantUpsertState>(
    'should invoke insertPlant on SaveButtonPressed event when id field is empty',
    setUp: () {
      when(mockPlantService.insertPlant(plantWithNoId)).thenAnswer((_) async => Right(plantWithNoId));
    },
    build: () => PlantUpsertBloc(existingPlant: plantWithNoId, onPlantInserted: (plant) async => Right(plant)),
    act: (bloc) {
      bloc.add(SaveButtonPressed());
    },
    expect: () {
      verify(mockPlantService.insertPlant(plantWithNoId)).called(1);
      verifyNever(mockPlantService.updatePlant(plantWithNoId));
      return <PlantUpsertState>[];
    },
  );
}
