import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/constants/app_decoration.dart';
import 'package:garden/common/constants/app_text.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';

class PlantUpsertNameField extends StatelessWidget {
  const PlantUpsertNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
