import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/model/plant/plant.dart';

part 'plant_list_state.freezed.dart';

enum PlantListStateType {
  initial,
  inProgress,
  fetched,
  successfullyAdded,
  successfullyEdited,
}

@freezed
class PlantListState with _$PlantListState {
  factory PlantListState.initial({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateInitial;

  factory PlantListState.inProgress({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateInProgress;

  factory PlantListState.fetchedData({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateFetchedData;

  factory PlantListState.reachedEnd({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateReachedEnd;

  factory PlantListState.successfullyAdded({
    @Default([]) List<Plant> plants,
    String? searchText,
    required Plant plant,
  }) = PlantListStateSuccessfullyAdded;

  factory PlantListState.upsertError({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateUpsertError;
}
