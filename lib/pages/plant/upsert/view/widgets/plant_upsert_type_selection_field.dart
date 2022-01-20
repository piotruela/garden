import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden/common/widget/plant_type_label.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_bloc.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_state.dart';

class PlantUpsertTypeSelectionField extends StatelessWidget {
  const PlantUpsertTypeSelectionField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantUpsertBloc, PlantUpsertState>(
      builder: (BuildContext context, state) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: PlantType.values.length,
            itemBuilder: (BuildContext context, int index) {
              final plantType = PlantType.values[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => context.read<PlantUpsertBloc>().add(PlantTypeSelected(plantType)),
                    child: PlantTypeLabel(
                      type: plantType,
                      isSelected: state.plantType == plantType,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
          ),
        );
      },
    );
  }
}
