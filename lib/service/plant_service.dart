import 'package:dartz/dartz.dart';
import 'package:garden/model/database/plant.dart' as en;
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/service/database/dao/plant/plant_dao.dart';
import 'package:uuid/uuid.dart';

class PlantService {
  final PlantDao dao;
  final Uuid uuid;

  PlantService(this.dao, this.uuid);

  Future<Either<DatabaseFailure, List<Plant>>> getPlants({String? searchText, required int offset}) async {
    List<en.Plant> plantsList;
    try {
      if (searchText != null) {
        plantsList = await dao.searchPlants("%$searchText%", offset, 10);
      } else {
        plantsList = await dao.getPlants(offset, 10);
      }
      return Right(plantsList.map((e) => Plant.fromEntity(e)).toList());
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }

  Future<Either<DatabaseFailure, Plant>> insertPlant(Plant plant) async {
    try {
      await dao.insertPlant(plant.toEntity(id: uuid.v1()));
      return Right(plant);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }

  Future<Either<DatabaseFailure, Plant>> updatePlant(Plant plant) async {
    try {
      await dao.updatePlant(plant.toEntity());
      return Right(plant);
    } catch (_) {
      return Left(DatabaseFailure());
    }
  }
}
