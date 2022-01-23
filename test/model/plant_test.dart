import 'package:flutter_test/flutter_test.dart';
import 'package:garden/model/database/plant.dart' as en;
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';

void main() {
  test('should create plant object from entity object', () {
    const id = 'test-id';
    const name = 'test-name';
    const type = 'grasses';
    final plantingDate = DateTime(2022);

    final entity = en.Plant(id, name, type, plantingDate.toString());
    final plant = Plant.fromEntity(entity);

    expect(plant.id, id);
    expect(plant.name, name);
    expect(plant.type, PlantType.grasses);
    expect(plant.plantingDate, plantingDate);
  });

  test('should create entity object from plant object', () {
    const id = 'test-id';
    const name = 'test-name';
    const type = PlantType.grasses;
    final plantingDate = DateTime(2022);

    final plant = Plant(id: id, name: name, type: type, plantingDate: plantingDate);
    final entity = plant.toEntity();

    expect(entity.id, id);
    expect(entity.name, name);
    expect(entity.type, 'grasses');
    expect(entity.plantingDate, plantingDate.toString());
  });

  test('should set new id when passed to toEntity() method', () {
    const id = 'test-id';
    const newId = 'new-test-id';
    const name = 'test-name';
    const type = PlantType.grasses;
    final plantingDate = DateTime(2022);

    final plant = Plant(id: id, name: name, type: type, plantingDate: plantingDate);
    final entity = plant.toEntity(id: newId);

    expect(entity.id, newId);
  });
}
