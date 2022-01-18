import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        onAddPlantPressed: () {}, //TODO: Navigate to add plant page
        onPlantPressed: (_) {}, //TODO: Navigate to edit plant page
      )..add(InitializePage()),
      child: const PlantListView(),
    );
  }
}
