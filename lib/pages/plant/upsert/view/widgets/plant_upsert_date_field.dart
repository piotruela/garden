import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_colors.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_state.dart';
import 'package:intl/intl.dart';

class PlantUpsertDateField extends StatelessWidget {
  const PlantUpsertDateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantUpsertBloc, PlantUpsertState>(
      builder: (BuildContext context, state) {
        return SizedBox(
          height: 46,
          child: GestureDetector(
            onTap: () => selectDate(context, state),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: const Icon(Icons.calendar_today),
                hintStyle: AppText.primaryText.copyWith(fontSize: 18),
                hintText: state.plantingDate != null ? DateFormat("dd/MM/yyyy").format(state.plantingDate!) : "",
                disabledBorder: AppDecoration.focusedBorder,
              ),
            ),
          ),
        );
      },
    );
  }

  void selectDate(BuildContext context, PlantUpsertState state) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: state.plantingDate ?? DateTime.now(),
      firstDate: DateTime(1977),
      lastDate: DateTime(2077),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.darkGreen,
              onPrimary: Colors.white,
              surface: AppColors.primary,
              onSurface: AppColors.darkGreen,
            ),
            dialogBackgroundColor: AppColors.primary,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      context.read<PlantUpsertBloc>().add(PlantingDateChanged(selectedDate));
    }
  }
}
