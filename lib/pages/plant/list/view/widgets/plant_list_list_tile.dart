import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/plant_type_label.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:intl/intl.dart';

class PlantListListTile extends StatelessWidget {
  final Plant plant;

  const PlantListListTile({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PlantListBloc>().add(MoveToUpsertPage(existingPlant: plant)),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Row(
            children: [
              _TileInitialsAvatar(name: plant.name),
              const SizedBox(width: 8),
              _TileContent(name: plant.name, plantingDate: plant.plantingDate),
              PlantTypeLabel(type: plant.type),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileInitialsAvatar extends StatelessWidget {
  final String name;

  const _TileInitialsAvatar({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Text(
            (name.characters.first + name.characters.last).toUpperCase(),
            style: AppText.primaryText,
          ),
        ),
      ),
    );
  }
}

class _TileContent extends StatelessWidget {
  final String name;
  final DateTime plantingDate;

  const _TileContent({
    Key? key,
    required this.name,
    required this.plantingDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppText.primaryText.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            "Planted at ${DateFormat("dd/MM/yyyy").format(plantingDate)}",
            style: AppText.secondaryText,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
