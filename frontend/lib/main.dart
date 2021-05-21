import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';

import 'core/core_container.dart';
import 'core/data/local/tm_dio_client.dart';
import 'core/infrastructure/localization/app_localizations.dart';
import 'core/infrastructure/localization/bloc/language_bloc.dart';
import 'core/infrastructure/log/bloc_logger.dart';
import 'core/infrastructure/log/logger.dart';

void main() async {
  // E' necessario aggiungerlo prima della dependency injection
  WidgetsFlutterBinding.ensureInitialized();

  await CoreContainer.init();

  Bloc.observer = LoggerBlocDelegate();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runZonedGuarded(() {
    runApp(TMApp());
  }, Logger.error);
}

class TMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp(
          title: 'Studio Lab',
          navigatorKey: navigatorKey,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('it', 'IT'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: languageState.locale,
          theme: ThemeData(
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: Color(0xffffffff),
            primaryColor: TMColors.primary,
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(),
        );
      },
    );
  }
}
