import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garden/model/database/plant.dart' as en;
import 'package:garden/model/plant/type/plant_type.dart';

part 'plant.freezed.dart';

@freezed
class Plant with _$Plant {
  const Plant._();

  factory Plant({
    String? id,
    required String name,
    required PlantType type,
    required DateTime plantingDate,
  }) = _Plant;

  factory Plant.fromEntity(en.Plant entity) {
    return Plant(
      id: entity.id,
      name: entity.name,
      type: PlantType.values.firstWhere((element) => describeEnum(element) == entity.type),
      plantingDate: DateTime.parse(entity.plantingDate),
    );
  }

  en.Plant toEntity({String? id}) {
    return en.Plant(
      id ?? this.id!,
      name,
      describeEnum(type),
      plantingDate.toString(),
    );
  }
}
