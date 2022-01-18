import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';

class AppDecoration {
  static const enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: AppColors.lightGrey, width: 1.0),
  );

  static const focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: AppColors.darkGreen, width: 1.0),
  );
}
