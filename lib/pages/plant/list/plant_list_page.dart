import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/app/app_router.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/view/plant_list_view.dart';

class PlantListPage extends StatelessWidget {
  const PlantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = AutoRouter.of(context);
    return BlocProvider(
      lazy: false,
      create: (context) => PlantListBloc(
          onAddPlantPressed: () => navigator.push(PlantUpsertRoute()),
          onPlantPressed: (plant) => navigator.push(PlantUpsertRoute()))
        ..add(InitializePage()),
      child: const PlantListView(),
    );
  }
}
