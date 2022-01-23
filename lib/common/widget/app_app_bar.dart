import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/rounded_button.dart';

class AppAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final String buttonLabel;
  final bool isActionButtonActive;
  final PreferredSizeWidget? bottom;

  final Function() onActionButtonPressed;

  const AppAppBar({
    Key? key,
    required this.title,
    required this.buttonLabel,
    this.isActionButtonActive = true,
    this.bottom,
    required this.onActionButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: Text(
        title,
        style: AppText.primaryText.copyWith(fontSize: 24),
      ),
      actions: [
        RoundedButton(
          label: buttonLabel,
          isActive: isActionButtonActive,
          onPressed: onActionButtonPressed,
        ),
        const SizedBox(width: 16),
      ],
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom != null ? 100 : 70);
}
