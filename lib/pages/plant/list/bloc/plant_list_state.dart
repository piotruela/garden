import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/model/plant/plant.dart';

part 'plant_list_state.freezed.dart';

enum UpsertType { insert, update }

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

  factory PlantListState.fetchingError({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateFetchingError;

  factory PlantListState.reachedEnd({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateReachedEnd;

  factory PlantListState.upsertSuccess({
    @Default([]) List<Plant> plants,
    String? searchText,
    required Plant plant,
    required UpsertType upsertType,
  }) = PlantListStateSuccessfullyAdded;

  factory PlantListState.upsertError({
    @Default([]) List<Plant> plants,
    String? searchText,
  }) = PlantListStateUpsertError;
}
