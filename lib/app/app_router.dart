import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/pages/plant/list/plant_list_page.dart';
import 'package:garden/pages/plant/upsert/plant_upsert_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: PlantListPage, initial: true),
    AutoRoute<Either<DatabaseFailure, Plant>>(page: PlantUpsertPage),
  ],
)
class AppRouter extends _$AppRouter {}
