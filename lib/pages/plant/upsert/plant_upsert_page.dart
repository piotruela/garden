import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/view/plant_upsert_view.dart';

class PlantUpsertPage extends StatelessWidget {
  final Plant? existingPlant;

  const PlantUpsertPage({
    Key? key,
    this.existingPlant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = AutoRouter.of(context);
    return BlocProvider(
      create: (BuildContext context) => PlantUpsertBloc(onSaveButtonPressed: () => navigator.pop()),
      child: PlantUpsertView(isEdit: existingPlant != null),
    );
  }
}
