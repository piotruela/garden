part of 'plant_upsert_bloc.dart';

abstract class PlantUpsertState extends Equatable {
  const PlantUpsertState();
}

class PlantUpsertInitial extends PlantUpsertState {
  @override
  List<Object> get props => [];
}
