import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourm_app/core/infrastructure/network_info.dart';

import 'core/data/local/tm_database.dart';

final sl = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules
    sl.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);

    sl.registerLazySingleton(() => FlutterSecureStorage());

    final database = await $FloorTMDatabase.databaseBuilder('tourm.db').build();
    sl.registerLazySingleton(() => database);

    sl.registerLazySingleton(() => database.mainDatasource);
  }

  static List<BlocProvider> getBlocProviders() {
    // get all modules providers
    return [];
  }
}
