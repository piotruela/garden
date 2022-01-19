import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/extensions.dart';
import 'package:garden/model/plant/type/plant_type.dart';

class PlantTypeLabel extends StatelessWidget {
  final PlantType type;
  final bool isSelected;

  const PlantTypeLabel({
    Key? key,
    required this.type,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isSelected ? selectedDecoration : unselectedDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          describeEnum(type).capitalize(),
          style: AppText.secondaryTextBold.copyWith(color: color),
        ),
      ),
    );
  }

  Color get color => AppColors.getTypeColor(type);

  BoxDecoration get selectedDecoration => BoxDecoration(
        color: color.lighten(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(2, 4),
            blurRadius: 3,
          ),
        ],
      );

  BoxDecoration get unselectedDecoration => BoxDecoration(
        color: color.lighten(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      );
}
