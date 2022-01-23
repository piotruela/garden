import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';

class PlantListAppBarSearchField extends StatelessWidget with PreferredSizeWidget {
  const PlantListAppBarSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 14.0),
      child: SizedBox(
        height: 34,
        child: TextField(
          cursorHeight: 20,
          cursorColor: AppColors.darkGreen,
          style: AppText.secondaryText.copyWith(fontSize: 14, color: Colors.black),
          decoration: InputDecoration(
            hintText: "Search for plant",
            hintStyle: AppText.secondaryText.copyWith(fontSize: 14, color: AppColors.darkGrey),
            prefixIcon: const Icon(Icons.search, color: AppColors.darkGrey),
            contentPadding: EdgeInsets.zero,
            enabledBorder: AppDecoration.enabledBorder,
            border: AppDecoration.enabledBorder,
            focusedBorder: AppDecoration.focusedBorder,
          ),
          onChanged: (value) => context.read<PlantListBloc>().add(SearchTextChanged(value)),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
