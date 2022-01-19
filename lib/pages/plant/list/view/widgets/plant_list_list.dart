import 'package:flutter/material.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_list_tile.dart';

class PlantListList extends StatelessWidget {
  final List<Plant> plants;

  const PlantListList({
    Key? key,
    required this.plants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ListView.separated(
        itemCount: plants.length,
        itemBuilder: (BuildContext context, index) => PlantListListTile(plant: plants[index]),
        separatorBuilder: (BuildContext context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
