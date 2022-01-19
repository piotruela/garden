import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_body.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      appBar: AppAppBar(
        title: "Garden",
        buttonLabel: "+ Add plant",
        bottom: const _AppBarSearchField(),
        onActionButtonPressed: () => context.read<PlantListBloc>().add(AddPlantButtonPressed()),
      ),
      body: const PlantListBody(),
    );
  }
}

class _AppBarSearchField extends StatelessWidget with PreferredSizeWidget {
  const _AppBarSearchField({Key? key}) : super(key: key);

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
