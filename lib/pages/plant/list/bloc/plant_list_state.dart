part of 'plant_list_bloc.dart';

abstract class PlantListState extends Equatable {
  const PlantListState();
}

class PlantListInitial extends PlantListState {
  @override
  List<Object> get props => [];
}
