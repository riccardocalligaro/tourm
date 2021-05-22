import 'package:floor/floor.dart';

@entity
class BeaconLocalModel {
  @primaryKey
  final String uuid;

  final String name;

  BeaconLocalModel(this.uuid, this.name);
}
