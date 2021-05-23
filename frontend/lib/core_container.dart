import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tourm_app/core/infrastructure/network_info.dart';
import 'package:tourm_app/data/datasource/tm_remote_datasource.dart';
import 'package:tourm_app/data/repository/articles_repository_impl.dart';
import 'package:tourm_app/data/repository/rooms_repository_impl.dart';
import 'package:tourm_app/domain/repository/articles_repository.dart';

import 'core/data/local/tm_database.dart';
import 'core/data/remote/tm_dio_client.dart';
import 'domain/repository/rooms_repository.dart';

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

    sl.registerLazySingleton<Dio>(
      () => TMDioClient(
        sharedPreferences: sl(),
      ).createDio(),
    );
    sl.registerLazySingleton(() => TMRemoteDatasource(dio: sl()));

    sl.registerLazySingleton<ArticlesRepository>(
      () => ArticlesRepositoryImpl(
        remoteDatasource: sl(),
      ),
    );

    sl.registerLazySingleton<RoomsRepository>(
      () => RoomsRepositoryImpl(
        remoteDatasource: sl(),
      ),
    );
  }

  static List<BlocProvider> getBlocProviders() {
    // get all modules providers
    return [];
  }
}
