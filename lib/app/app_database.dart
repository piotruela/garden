import 'dart:async';

import 'package:floor/floor.dart';
import 'package:garden/model/database/plant.dart';
import 'package:garden/service/database/dao/plant/plant_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Plant])
abstract class AppDatabase extends FloorDatabase {
  PlantDao get plantDao;
}
