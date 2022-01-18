import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_empty_list_widget.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_list.dart';

class PlantListBody extends StatelessWidget {
  const PlantListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantListBloc, PlantListState>(
      builder: (BuildContext context, state) {
        switch (state.type) {
          case PlantListStateType.fetched:
            if (state.plants.isEmpty) return const PlantListEmptyListWidget();
            return PlantListList(plants: state.plants);
          case PlantListStateType.initial:
          case PlantListStateType.inProgress:
          default:
            return const Center(child: SpinKitThreeBounce(color: AppColors.lightBrown, size: 17));
        }
      },
    );
  }
}
