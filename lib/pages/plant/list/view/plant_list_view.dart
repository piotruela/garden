import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/common/widget/app_snack_bar.dart';
import 'package:garden/common/widget/un_focus_on_tap.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_state.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_body.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnFocusOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.primary,
        appBar: AppAppBar(
          title: "Garden",
          buttonLabel: "+ Add plant",
          bottom: const _AppBarSearchField(),
          onActionButtonPressed: () => context.read<PlantListBloc>().add(const MoveToUpsertPage()),
        ),
        body: BlocConsumer<PlantListBloc, PlantListState>(
          listener: (BuildContext context, state) {
            state.maybeMap(
              upsertSuccess: (state) {
                _showSuccessSnackBar(context, type: state.upsertType, plantName: state.plant.name);
                context.read<PlantListBloc>().add(InitializePage());
              },
              upsertError: (_) {
                AppSnackBar(backgroundColor: AppColors.error, content: const Text("There was an error :C"))
                    .show(context);
                context.read<PlantListBloc>().add(InitializePage());
              },
              orElse: () {},
            );
          },
          builder: (BuildContext context, state) {
            return state.maybeMap(
              fetchedData: (fetchedDataState) => PlantListBody(state: fetchedDataState),
              reachedEnd: (reachedEndState) => PlantListBody(state: reachedEndState),
              orElse: () => const Center(child: SpinKitThreeBounce(color: AppColors.lightBrown, size: 17)),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(
    BuildContext context, {
    required UpsertType type,
    required String plantName,
  }) {
    final text = type == UpsertType.insert ? "Added $plantName to your collection" : "Successfully edited $plantName";
    return AppSnackBar(content: Text(text)).show(context);
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
