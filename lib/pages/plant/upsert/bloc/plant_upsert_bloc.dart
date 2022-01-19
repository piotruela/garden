import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/model/plant/plant.dart';

part 'plant_upsert_event.dart';
part 'plant_upsert_state.dart';

class PlantUpsertBloc extends Bloc<PlantUpsertEvent, PlantUpsertState> {
  PlantUpsertBloc({
    Plant? existingPlant,
    required Function() onSaveButtonPressed,
  }) : super(PlantUpsertInitial()) {
    on<SaveButtonPressed>((_, __) => onSaveButtonPressed());
  }
}
