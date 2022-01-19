import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/common/widget/app_app_bar.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';

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
        title: isEdit ? "Edit plant" : "Add plant",
        buttonLabel: "Save",
        onActionButtonPressed: () => context.read<PlantUpsertBloc>().add(SaveButtonPressed()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: const [
            _LabeledField(
              label: "Name",
              field: TextField(
                decoration: InputDecoration(
                  enabledBorder: AppDecoration.enabledBorder,
                  focusedBorder: AppDecoration.focusedBorder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget field;

  const _LabeledField({
    Key? key,
    required this.label,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.primaryText),
        field,
      ],
    );
  }
}
