import 'package:flutter_test/flutter_test.dart';
import 'package:garden/model/database/plant.dart' as en;
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/service/database/dao/plant/plant_dao.dart';
import 'package:garden/service/plant_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'plant_service_test.mocks.dart';

@GenerateMocks([PlantDao, Uuid])
void main() {
  final plantDaoMock = MockPlantDao();
  final uuidMock = MockUuid();

  group('getPlants() method', () {
    test('should invoke dao.getPlants() method with passed offset', () async {
      const offset = 20;
      when(plantDaoMock.getPlants(20, 10)).thenAnswer((_) async => <en.Plant>[]);
      final plantService = PlantService(plantDaoMock, uuidMock);

      await plantService.getPlants(offset: offset);

      verify(plantDaoMock.getPlants(offset, 10));
    });

    test('should invoke dao.getPlants() method when no searchText is passed', () async {
      when(plantDaoMock.getPlants(0, 10)).thenAnswer((_) async => <en.Plant>[]);
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.getPlants(offset: 0);

      result.fold((_) => fail('test failed'), (right) {
        verify(plantDaoMock.getPlants(0, 10)).called(1);
        expect(right, equals([]));
      });
    });

    test('should invoke dao.searchPlants() method when searchText is passed', () async {
      const searchText = 'search';
      const searchTextWithPrefixAndSuffix = "%$searchText%";
      when(plantDaoMock.searchPlants(searchTextWithPrefixAndSuffix, 0, 10)).thenAnswer((_) async => <en.Plant>[]);
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.getPlants(offset: 0, searchText: searchText);

      verifyNever(plantDaoMock.getPlants(0, 10));
      result.fold((_) => fail('test failed'), (right) {
        verify(plantDaoMock.searchPlants(searchTextWithPrefixAndSuffix, 0, 10)).called(1);
        expect(right, equals([]));
      });
    });

    test('should return DatabaseFailure on error', () async {
      when(plantDaoMock.getPlants(any, any)).thenThrow(Exception());
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.getPlants(offset: 0);

      result.fold(
        (left) => expect(left, equals(DatabaseFailure())),
        (_) => fail('test failed'),
      );
    });
  });

  group('insertPlant() method', () {
    const uuid = 'test-uuid';
    when(uuidMock.v1()).thenReturn(uuid);
    final plant = Plant(name: 'name', type: PlantType.grasses, plantingDate: DateTime(2022));

    test('should return passed plant when insert succeeded', () async {
      when(plantDaoMock.insertPlant(any)).thenAnswer((_) async => plant);
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.insertPlant(plant);

      result.fold(
        (_) => fail('test failed'),
        (right) => expect(right, plant),
      );
    });

    test('should return DatabaseFailure when insert failed', () async {
      when(plantDaoMock.insertPlant(any)).thenThrow(Exception());
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.insertPlant(plant);

      result.fold(
        (left) => expect(left, equals(DatabaseFailure())),
        (right) => fail('test failed'),
      );
    });
  });

  group('updatePlant() method', () {
    final plant = Plant(id: 'uuid', name: 'name', type: PlantType.grasses, plantingDate: DateTime(2022));

    test('should return passed plant when update succeeded', () async {
      when(plantDaoMock.updatePlant(any)).thenAnswer((_) async => plant);
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.updatePlant(plant);

      result.fold(
        (_) => fail('test failed'),
        (right) => expect(right, plant),
      );
    });

    test('should return DatabaseFailure when update failed', () async {
      when(plantDaoMock.updatePlant(any)).thenThrow(Exception());
      final plantService = PlantService(plantDaoMock, uuidMock);

      final result = await plantService.updatePlant(plant);

      result.fold(
        (left) => expect(left, equals(DatabaseFailure())),
        (right) => fail('test failed'),
      );
    });
  });
}
