import 'package:garden/model/plant/plant.dart';
import 'package:garden/service/database/dao/plant/plant_dao.dart';

class PlantService {
  final PlantDao dao;

  PlantService(this.dao);

  Future<List<Plant>> getPlants({required int offset}) async {
    final list = await dao.getPlants(offset, 10);
    return list.map((e) => Plant.fromEntity(e)).toList();
  }
}
