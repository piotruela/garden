import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';

class RoundedButton extends StatelessWidget {
  final String label;

  final Function() onPressed;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: onPressed,
          child: Container(
            decoration:
                const BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              child: Text(label, style: AppText.secondaryTextBold.copyWith(color: AppColors.darkGreen)),
            ),
          ),
        ),
      ],
    );
  }
}
