import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:garden/extensions.dart';
import 'package:garden/model/error/failure.dart';
import 'package:garden/model/plant/plant.dart';
import 'package:garden/pages/plant/list/bloc/plant_list_state.dart';
import 'package:garden/service/plant_service.dart';
import 'package:get_it/get_it.dart';

part 'plant_list_event.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  final Future<Either<DatabaseFailure, Plant>?> Function(Plant? existingPlant) onMoveToUpsertPagePressed;

  final _plantService = GetIt.I<PlantService>();

  PlantListBloc({
    required this.onMoveToUpsertPagePressed,
  }) : super(PlantListState.initial()) {
    on<InitializePage>(_onInitializePage);
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ThresholdReached>(_onThresholdReached);
    on<MoveToUpsertPage>(_onMoveToUpsertPage);
  }

  void _onInitializePage(
    InitializePage event,
    Emitter<PlantListState> emit,
  ) async {
    emit(PlantListState.inProgress());
    final result = await _plantService.getPlants(offset: 0);
    emit(PlantListState.fetchedData(plants: result));
  }

  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<PlantListState> emit,
  ) async {
    final searchText = event.searchText.takeIf((it) => it.isNotEmpty);
    final result = await _plantService.getPlants(searchText: searchText, offset: 0);
    emit(PlantListState.fetchedData(plants: result, searchText: searchText));
  }

  void _onThresholdReached(
    ThresholdReached event,
    Emitter<PlantListState> emit,
  ) async {
    if (state is PlantListStateReachedEnd) return;
    final result = await _plantService.getPlants(searchText: event.searchText, offset: state.plants.length);
    if (result.isEmpty) {
      emit(PlantListState.reachedEnd(searchText: state.searchText, plants: state.plants));
      return;
    }
    emit(state.copyWith(plants: List<Plant>.from(state.plants)..addAll(result), searchText: state.searchText));
  }

  void _onMoveToUpsertPage(
    MoveToUpsertPage event,
    Emitter<PlantListState> emit,
  ) async {
    final result = await onMoveToUpsertPagePressed(event.existingPlant);
    if (result == null) return;
    emit(
      result.fold(
        (exception) => PlantListState.upsertError(plants: state.plants),
        (plant) => PlantListState.upsertSuccess(
          plants: state.plants,
          plant: plant,
          upsertType: event.existingPlant != null ? UpsertType.update : UpsertType.insert,
        ),
      ),
    );
  }
}
