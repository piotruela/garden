import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garden/common/constants/app_images.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/extensions.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:provider/src/provider.dart';

class PlantListEmptyListWidget extends StatelessWidget {
  const PlantListEmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(AppImages.flowers)),
        Text(
          "No plants",
          style: AppText.primaryText.copyWith(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppText.secondaryText.copyWith(fontSize: 14),
              children: [
                const TextSpan(text: "You don't have any plants yet.\n"),
                TextSpan(
                  text: "Click here",
                  style: AppText.secondaryText.copyWith(fontSize: 14, decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = () => context.read<PlantListBloc>().add(AddPlant()),
                ),
                const TextSpan(text: " to add first."),
              ],
            ),
          ),
        )
      ].separatedWith(const SizedBox(height: 12)),
    );
  }
}
