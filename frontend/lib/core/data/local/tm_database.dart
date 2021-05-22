// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tourm_app/data/datasource/tm_local_datasource.dart';
import 'package:tourm_app/data/model/local/beacon_local_model.dart';

part 'tm_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [BeaconLocalModel])
abstract class TMDatabase extends FloorDatabase {
  TMLocalDatasource get mainDatasource;
}
