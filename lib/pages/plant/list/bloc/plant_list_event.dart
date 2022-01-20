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
  final int noOfElements;

  const ThresholdReached({this.searchText, this.noOfElements = 0});

  @override
  List<Object?> get props => [searchText];
}

class MoveToUpsertPage extends PlantListEvent {
  final Plant? existingPlant;

  const MoveToUpsertPage({this.existingPlant});

  @override
  List<Object?> get props => [existingPlant];
}

class SearchTextChanged extends PlantListEvent {
  final String searchText;

  const SearchTextChanged(this.searchText);

  @override
  List<Object?> get props => [searchText];
}
