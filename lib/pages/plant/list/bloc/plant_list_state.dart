part of 'plant_list_bloc.dart';

enum PlantListStateType {
  initial,
  inProgress,
  fetched,
}

class PlantListState extends Equatable {
  final PlantListStateType type;
  final List<Plant> plants;

  const PlantListState({
    required this.type,
    this.plants = const [],
  });

  @override
  List<Object?> get props => [type, plants];
}
