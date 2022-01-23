import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar({
    Key? key,
    Color backgroundColor = AppColors.darkGreen,
    required Widget content,
    Duration duration = const Duration(seconds: 2),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          content: DefaultTextStyle(
            child: content,
            style: AppText.secondaryTextBold.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          duration: duration,
          behavior: SnackBarBehavior.floating,
        );

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}
