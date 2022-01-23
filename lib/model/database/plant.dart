import 'package:floor/floor.dart';

@entity
class Plant {
  @PrimaryKey()
  final String id;

  final String name;
  final String type;
  final String plantingDate;

  Plant(this.id, this.name, this.type, this.plantingDate);
}
