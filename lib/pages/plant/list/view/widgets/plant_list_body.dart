import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garden/common/constants/app_images.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/extensions.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_state.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_list_tile.dart';

class PlantListBody extends StatelessWidget {
  final PlantListState state;

  const PlantListBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return state.plants.isNotEmpty ? _PlantsListWidget(state: state) : const _EmptyListWidget();
  }
}

class _PlantsListWidget extends StatelessWidget {
  final PlantListState state;

  const _PlantsListWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        if (scrollEnd.metrics.atEdge && scrollEnd.metrics.pixels != 0) {
          context.read<PlantListBloc>().add(ThresholdReached(
                searchText: state.searchText,
                noOfElements: state.plants.length,
              ));
        }
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          itemCount: state.plants.length,
          itemBuilder: (BuildContext context, index) => PlantListListTile(plant: state.plants[index]),
          separatorBuilder: (BuildContext context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}

class _EmptyListWidget extends StatelessWidget {
  const _EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(AppImages.flowers)),
        Text(
          "No plants",
          style: AppText.primaryText.copyWith(fontSize: 20),
        ),
      ].separatedWith(const SizedBox(height: 12)),
    );
  }
}
