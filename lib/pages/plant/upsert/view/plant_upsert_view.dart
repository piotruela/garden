import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/extensions.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_date_field.dart';
import 'package:garden/pages/plant/upsert/view/widgets/plant_upsert_type_selection_field.dart';

class PlantUpsertView extends StatelessWidget {
  final bool isEdit;

  const PlantUpsertView({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppAppBar(
        title: isEdit ? "Update plant" : "Add plant",
        buttonLabel: "Save",
        onActionButtonPressed: () => context.read<PlantUpsertBloc>().add(SaveButtonPressed()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _LabeledField(
              label: "Name",
              child: SizedBox(
                height: 46,
                child: TextFormField(
                  initialValue: context.read<PlantUpsertBloc>().state.plantName,
                  style: AppText.primaryText.copyWith(fontSize: 18),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    enabledBorder: AppDecoration.focusedBorder,
                    focusedBorder: AppDecoration.focusedBorder,
                  ),
                  onChanged: (value) => context.read<PlantUpsertBloc>().add(PlantNameChanged(value)),
                ),
              ),
            ),
            const _LabeledField(
              label: "Plant type",
              child: PlantUpsertTypeSelectionField(),
            ),
            const _LabeledField(
              label: "Planting date",
              child: PlantUpsertDateField(),
            ),
          ].separatedWith(const SizedBox(height: 12)),
        ),
      ),
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
