import 'package:flutter_test/flutter_test.dart';
import 'package:garden/model/plant/type/plant_type.dart';
import 'package:garden/pages/plant/upsert/bloc/plant_upsert_state.dart';

void main() {
  test('should consider form as valid when plantName, plantType and plantingDate fields are filled', () {
    PlantUpsertState state = PlantUpsertState();

    expect(state.isFormValid, false);
    state = state.copyWith(plantName: 'name');
    expect(state.isFormValid, false);
    state = state.copyWith(plantType: PlantType.bulbs);
    expect(state.isFormValid, false);
    state = state.copyWith(plantingDate: DateTime(2022));
    expect(state.isFormValid, true);
    state = state.copyWith(plantName: '');
    expect(state.isFormValid, false);
  });
}
