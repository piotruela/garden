part of 'plant_upsert_bloc.dart';

abstract class PlantUpsertEvent extends Equatable {
  const PlantUpsertEvent();
}

class SaveButtonPressed extends PlantUpsertEvent {
  @override
  List<Object?> get props => [];
}

class PlantNameChanged extends PlantUpsertEvent {
  final String plantName;

  const PlantNameChanged(this.plantName);

  @override
  List<Object?> get props => [plantName];
}

class PlantTypeSelected extends PlantUpsertEvent {
  final PlantType type;

  const PlantTypeSelected(this.type);

  @override
  List<Object?> get props => [type];
}

class PlantingDateChanged extends PlantUpsertEvent {
  final DateTime plantingDate;

  const PlantingDateChanged(this.plantingDate);

  @override
  List<Object?> get props => [plantingDate];
}
