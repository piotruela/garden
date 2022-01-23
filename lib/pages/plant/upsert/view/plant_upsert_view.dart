import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/common/widget/un_focus_on_tap.dart';
import 'package:garden/extensions.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_state.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_date_field.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_name_field.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_type_selection_field.dart';

class PlantUpsertView extends StatelessWidget {
  final bool isEdit;

  const PlantUpsertView({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantUpsertBloc, PlantUpsertState>(
      builder: (BuildContext context, state) {
        return UnFocusOnTap(
          child: Scaffold(
            backgroundColor: AppColors.primary,
            appBar: AppAppBar(
              title: isEdit ? "Update plant" : "Add plant",
              buttonLabel: "Save",
              isActionButtonActive: state.isFormValid,
              onActionButtonPressed: () => context.read<PlantUpsertBloc>().add(SaveButtonPressed()),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const _LabeledField(label: "Name", child: PlantUpsertNameField()),
                  const _LabeledField(label: "Plant type", child: PlantUpsertTypeSelectionField()),
                  const _LabeledField(label: "Planting date", child: PlantUpsertDateField()),
                ].separatedWith(const SizedBox(height: 12)),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({
    Key? key,
    required this.label,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.primaryText),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
