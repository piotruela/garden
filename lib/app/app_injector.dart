import 'package:garden/app/app_database.dart';
import 'package:get_it/get_it.dart';

class AppInjector {
  const AppInjector._();

  static void setup(AppDatabase appDatabase) {
    final getIt = GetIt.I;
    getIt..registerSingleton(appDatabase.plantDao);
  }
}
