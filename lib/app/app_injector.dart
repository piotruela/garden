import 'package:garden/app/app_database.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class AppInjector {
  const AppInjector._();

  static void setup(AppDatabase appDatabase) {
    final getIt = GetIt.I;
    getIt
      ..registerSingleton(appDatabase.plantDao)
      ..registerSingleton(const Uuid())
      ..registerSingleton(PlantService(getIt.get(), getIt.get()));
  }
}
