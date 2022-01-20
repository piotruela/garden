import 'package:flutter/material.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final bool isActive;

  final Function() onPressed;

  const RoundedButton({
    Key? key,
    required this.label,
    this.isActive = true,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          onTap: isActive ? onPressed : () {},
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.lightGrey.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: isActive
                  ? [BoxShadow(color: Colors.grey.withOpacity(0.5), offset: const Offset(2, 4), blurRadius: 3)]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              child: Text(
                label,
                style: AppText.secondaryTextBold.copyWith(
                  color: isActive ? AppColors.darkGreen : AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
