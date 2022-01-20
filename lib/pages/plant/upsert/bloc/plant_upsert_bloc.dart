import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';

import 'plant_upsert_state.dart';

part 'plant_upsert_event.dart';

class PlantUpsertBloc extends Bloc<PlantUpsertEvent, PlantUpsertState> {
  final Function(Either<DatabaseFailure, Plant>) onPlantInserted;

  final _plantService = GetIt.I<PlantService>();

  PlantUpsertBloc({
    Plant? existingPlant,
    required this.onPlantInserted,
  }) : super(PlantUpsertState(
          plantId: existingPlant?.id,
          plantName: existingPlant?.name,
          plantType: existingPlant?.type,
          plantingDate: existingPlant?.plantingDate,
        )) {
    on<PlantTypeSelected>(_onPlantTypeSelected);
    on<PlantNameChanged>(_onPlantNameChanged);
    on<PlantingDateChanged>(_onPlantingDateChanged);
    on<SaveButtonPressed>(_onSaveButtonPressed);
  }

  void _onPlantTypeSelected(
    PlantTypeSelected event,
    Emitter<PlantUpsertState> emit,
  ) {
    emit(state.copyWith(plantType: event.type));
  }

  void _onPlantNameChanged(
    PlantNameChanged event,
    Emitter<PlantUpsertState> emit,
  ) {
    emit(state.copyWith(plantName: event.plantName));
  }

  void _onPlantingDateChanged(
    PlantingDateChanged event,
    Emitter<PlantUpsertState> emit,
  ) {
    emit(state.copyWith(plantingDate: event.plantingDate));
  }

  void _onSaveButtonPressed(
    SaveButtonPressed event,
    Emitter<PlantUpsertState> emit,
  ) async {
    Either<DatabaseFailure, Plant> result;
    if (state.plantId != null) {
      result = await _plantService.updatePlant(_getPlantFromStateFields());
    } else {
      result = await _plantService.insertPlant(_getPlantFromStateFields());
    }
    onPlantInserted(result);
  }

  Plant _getPlantFromStateFields() {
    return Plant(
      id: state.plantId,
      name: state.plantName!,
      type: state.plantType!,
      plantingDate: state.plantingDate!,
    );
  }
}
