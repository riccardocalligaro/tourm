import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tourm_app/core/data/local/tm_dio_client.dart';
import 'infrastructure/network_info.dart';

final pm = GetIt.instance;

class CoreContainer {
  static Future<void> init() async {
    // wait for all modules

    pm.registerLazySingleton<Connectivity>(
      () => Connectivity(),
    );

    pm.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: pm()),
    );

    final sharedPreferences = await SharedPreferences.getInstance();
    pm.registerLazySingleton(() => sharedPreferences);

    pm.registerLazySingleton<Dio>(TMDioClient.createDio);
  }

  static List<BlocProvider> getBlocProviders() {
    // get all modules providers
    return [];
  }
}
