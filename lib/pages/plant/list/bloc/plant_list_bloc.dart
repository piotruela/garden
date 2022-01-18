import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';

part 'plant_list_event.dart';
part 'plant_list_state.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  final Function() onAddPlantPressed;
  final Function(Plant plant) onPlantPressed;

  final _plantService = GetIt.I<PlantService>();

  PlantListBloc({
    required this.onAddPlantPressed,
    required this.onPlantPressed,
  }) : super(const PlantListState(type: PlantListStateType.initial)) {
    on<InitializePage>(_onInitializePage);
  }

  void _onInitializePage(
    InitializePage event,
    Emitter<PlantListState> emit,
  ) async {
    emit(const PlantListState(type: PlantListStateType.inProgress));
    final result = await _plantService.getPlants(offset: 0);
    emit(PlantListState(type: PlantListStateType.fetched, plants: result));
    return;
  }
}
