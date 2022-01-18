import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/extensions.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:intl/intl.dart';

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
        itemBuilder: (BuildContext context, index) {
          final plant = plants[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          plant.name.characters.first.toUpperCase() + plant.name.characters.last.toUpperCase(),
                          style: AppText.primaryText,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.name,
                          style: AppText.primaryText.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Planted at ${DateFormat("dd/MM/yyyy").format(plant.plantingDate)}",
                          style: AppText.secondaryText,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        describeEnum(plant.type).capitalize(),
                        style: AppText.secondaryTextBold.copyWith(color: AppColors.darkGreen),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
