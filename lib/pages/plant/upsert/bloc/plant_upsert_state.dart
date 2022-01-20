import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/model/plant/type/plant_type.dart';

part 'plant_upsert_state.freezed.dart';

@freezed
class PlantUpsertState with _$PlantUpsertState {
  const PlantUpsertState._();

  factory PlantUpsertState({
    String? plantId,
    String? plantName,
    PlantType? plantType,
    DateTime? plantingDate,
  }) = _PlantUpsertState;

  bool get isFormValid => plantName != null && plantName!.isNotEmpty && plantType != null && plantingDate != null;
}
