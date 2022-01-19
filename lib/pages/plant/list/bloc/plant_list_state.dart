part of 'plant_list_bloc.dart';

enum PlantListStateType {
  initial,
  inProgress,
  fetched,
}

class PlantListState extends Equatable {
  final PlantListStateType type;
  final List<Plant> plants;
  final String? searchText;
  final bool hasReachedEnd;

  const PlantListState({
    required this.type,
    this.searchText,
    this.hasReachedEnd = false,
    this.plants = const [],
  });

  @override
  List<Object?> get props => [type, plants, searchText, hasReachedEnd];
}
