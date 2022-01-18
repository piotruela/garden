import 'package:flutter/material.dart';
import 'package:garden/app/app_database.dart';
import 'package:garden/app/app_injector.dart';
import 'package:garden/app/app_router.dart';
import 'package:garden/common/constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  AppInjector.setup(database);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      theme: ThemeData(
        primaryColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.darkGreen),
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
