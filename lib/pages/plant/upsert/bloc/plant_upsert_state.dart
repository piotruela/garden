import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/model/plant/type/plant_type.dart';

part 'plant_upsert_state.freezed.dart';

enum PlantUpsertStateType { initial, submitting }

@freezed
class PlantUpsertState with _$PlantUpsertState {
  factory PlantUpsertState({
    required PlantUpsertStateType type,
    String? plantId,
    String? plantName,
    PlantType? plantType,
    DateTime? plantingDate,
  }) = _PlantUpsertState;
}
