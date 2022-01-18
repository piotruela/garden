import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:garden/pages/plant/list/plant_list_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: PlantListPage, initial: true),
  ],
)
class AppRouter extends _$AppRouter {}
