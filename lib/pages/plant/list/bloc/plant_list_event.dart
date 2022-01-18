part of 'plant_list_bloc.dart';

abstract class PlantListEvent extends Equatable {
  const PlantListEvent();
}

class InitializePage extends PlantListEvent {
  @override
  List<Object?> get props => [];
}

class FetchMoreElements extends PlantListEvent {
  @override
  List<Object?> get props => [];
}

class AddPlant extends PlantListEvent {
  @override
  List<Object?> get props => [];
}

class EditPlant extends PlantListEvent {
  @override
  List<Object?> get props => [];
}
