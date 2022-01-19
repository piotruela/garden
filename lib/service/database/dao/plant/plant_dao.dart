import 'package:floor/floor.dart';
import 'package:garden/model/database/plant.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant limit :count offset :offset')
  Future<List<Plant>> getPlants(int offset, int count);

  @Query('SELECT * FROM Plant WHERE name LIKE :name limit :count offset :offset')
  Future<List<Plant>> searchPlants(String name, int offset, int count);

  @insert
  Future<void> insertPlant(Plant plant);

  @update
  Future<void> updatePlant(Plant plant);
}
