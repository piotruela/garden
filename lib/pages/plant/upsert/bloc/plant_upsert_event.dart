part of 'plant_upsert_bloc.dart';

abstract class PlantUpsertEvent extends Equatable {
  const PlantUpsertEvent();
}

class SaveButtonPressed extends PlantUpsertEvent {
  @override
  List<Object?> get props => [];
}
