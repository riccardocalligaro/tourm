import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourm_app/core/presentation/customization/tm_colors.dart';
import 'package:tourm_app/presentation/navigator_page.dart';

import 'core/data/remote/tm_dio_client.dart';
import 'core/infrastructure/localization/app_localizations.dart';
import 'core/infrastructure/localization/bloc/language_bloc.dart';
import 'core/infrastructure/log/bloc_logger.dart';
import 'core/infrastructure/log/logger.dart';
import 'core_container.dart';

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
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
      ],
      child: TMApp(),
    ));
  }, Logger.error);
}

class TMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp(
          title: 'Tourm',
          navigatorKey: navigatorKey,
          supportedLocales: [
            Locale('it', 'IT'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: languageState.locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Quicksand',
            scaffoldBackgroundColor: Color(0xffffffff),
            primaryColor: TMColors.primary,
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: TMNavigator(),
        );
      },
    );
  }
}
