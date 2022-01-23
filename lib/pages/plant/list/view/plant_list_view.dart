import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_images.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/common/widget/app_snack_bar.dart';
import 'package:garden/common/widget/un_focus_on_tap.dart';
import 'package:garden/extensions.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_bloc.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_state.dart';
import 'package:garden/pages/plant/list/view/widgets/plant_list_app_bar_search_field.dart';
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
          bottom: const PlantListAppBarSearchField(),
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
                _showErrorSnackBar(context);
                context.read<PlantListBloc>().add(InitializePage());
              },
              orElse: () {},
            );
          },
          builder: (BuildContext context, state) {
            return state.maybeMap(
              fetchedData: (fetchedDataState) => PlantListBody(state: fetchedDataState),
              reachedEnd: (reachedEndState) => PlantListBody(state: reachedEndState),
              fetchingError: (fetchingError) => const PlantListErrorWidget(),
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

  void _showErrorSnackBar(BuildContext context) {
    return AppSnackBar(backgroundColor: AppColors.error, content: const Text("There was an error")).show(context);
  }
}

class PlantListErrorWidget extends StatelessWidget {
  const PlantListErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: SizedBox(height: 120, child: SvgPicture.asset(AppImages.error))),
        Text(
          "Error occurred",
          style: AppText.primaryText.copyWith(fontSize: 20),
        ),
      ].separatedWith(const SizedBox(height: 12)),
    );
  }
}
