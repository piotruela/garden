part of 'plant_list_bloc.dart';

abstract class PlantListEvent extends Equatable {
  const PlantListEvent();
}

class InitializePage extends PlantListEvent {
  @override
  List<Object?> get props => [];
}

class ThresholdReached extends PlantListEvent {
  final String? searchText;

  const ThresholdReached({this.searchText});

  @override
  List<Object?> get props => [searchText];
}

class AddPlantButtonPressed extends PlantListEvent {
  @override
  List<Object?> get props => [];
}

class PlantTilePressed extends PlantListEvent {
  final Plant plant;

  const PlantTilePressed(this.plant);

  @override
  List<Object?> get props => [plant];
}

class SearchTextChanged extends PlantListEvent {
  final String searchText;

  const SearchTextChanged(this.searchText);

  @override
  List<Object?> get props => [searchText];
}
