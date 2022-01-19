import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/extensions.dart';
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
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ThresholdReached>(_onThresholdReached);
    on<AddPlantButtonPressed>((_, __) => onAddPlantPressed());
  }

  void _onInitializePage(
    InitializePage event,
    Emitter<PlantListState> emit,
  ) async {
    emit(const PlantListState(type: PlantListStateType.inProgress));
    final result = await _plantService.getPlants(offset: 0);
    emit(PlantListState(type: PlantListStateType.fetched, plants: result));
  }

  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<PlantListState> emit,
  ) async {
    final searchText = event.searchText.takeIf((it) => it.isNotEmpty);
    final result = await _plantService.getPlants(searchText: searchText, offset: 0);
    emit(PlantListState(
      type: PlantListStateType.fetched,
      plants: result,
      searchText: searchText,
    ));
  }

  void _onThresholdReached(
    ThresholdReached event,
    Emitter<PlantListState> emit,
  ) async {
    if (state.hasReachedEnd) return;
    final result = await _plantService.getPlants(searchText: state.searchText, offset: state.plants.length);
    final newPlantsList = List<Plant>.from(state.plants)..addAll(result);
    emit(PlantListState(
      type: PlantListStateType.fetched,
      plants: newPlantsList,
      searchText: state.searchText,
      hasReachedEnd: result.isEmpty,
    ));
  }
}
