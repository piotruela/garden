import 'package:garden/model/database/plant.dart' as en;
import 'package:garden/model/plant/plant.dart';
import 'package:garden/service/database/dao/plant/plant_dao.dart';

class PlantService {
  final PlantDao dao;

  PlantService(this.dao);

  Future<List<Plant>> getPlants({String? searchText, required int offset}) async {
    List<en.Plant> plantsList;
    if (searchText != null) {
      plantsList = await dao.searchPlants("%$searchText%", offset, 1);
    } else {
      plantsList = await dao.getPlants(offset, 1);
    }
    return plantsList.map((e) => Plant.fromEntity(e)).toList();
  }
}
