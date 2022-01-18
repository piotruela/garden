import 'package:floor/floor.dart';
import 'package:garden/model/database/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant limit :count offset :offset')
  Future<List<Plant>> getPlants(int offset, int count);

  @Query('SELECT * FROM Plant WHERE name = :name limit :count offset :offset')
  Future<List<Plant>> searchPlants(String name, int offset, int count);

  @Query('SELECT * FROM Plant WHERE id = :id')
  Stream<Plant?> findPlantById(int id);

  @insert
  Future<void> insertPlant(Plant plant);

  @update
  Future<void> updatePlant(Plant plant);
}
