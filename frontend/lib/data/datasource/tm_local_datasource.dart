// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:tourm_app/data/model/local/beacon_local_model.dart';

@dao
abstract class TMLocalDatasource {
  @Query('SELECT * FROM beacons')
  Future<List<BeaconLocalModel>> getAllBeacons();

  @Query('SELECT * FROM beacons')
  Future<List<BeaconLocalModel>> watchAllBeacons();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateBeacon(BeaconLocalModel memoLocalModel);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBeacons(List<BeaconLocalModel> memosLocalModels);
}
