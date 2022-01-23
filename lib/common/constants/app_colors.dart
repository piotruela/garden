import 'package:flutter/material.dart';
import 'package:garden/model/plant/type/plant_type.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xffedf0e4);
  static const Color darkGreen = Color(0xff7a8e55);
  static const Color lightBrown = Color(0xffbd9b5e);
  static const Color lightGrey = Color(0xfff0f0f0);
  static const Color darkGrey = Color(0xff959292);
  static const Color error = Color(0xffA85959);

  static Color getTypeColor(PlantType type) {
    switch (type) {
      case PlantType.alpines:
        return darkGreen;
      case PlantType.aquatic:
        return const Color(0xff8B655D);
      case PlantType.bulbs:
        return const Color(0xff9C8760);
      case PlantType.carnivorous:
        return const Color(0xffFF4191);
      case PlantType.climbers:
        return Colors.red;
      case PlantType.ferns:
        return Colors.purple;
      case PlantType.trees:
        return Colors.teal;
      case PlantType.succulents:
        return Colors.orange;
      case PlantType.grasses:
        return Colors.green;
    }
  }
}
