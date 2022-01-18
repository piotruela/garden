import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/view/plant_list_view.dart';

class PlantListPage extends StatelessWidget {
  const PlantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantListBloc(),
      child: const PlantListView(),
    );
  }
}
