import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leaf_common/leaf_common.dart';
import 'package:flutter_leaf_navigation/leaf_navigation.dart';
import 'package:flutter_leaf_store/leaf_store.dart';

import 'src/app.dart';
import 'src/features/main/blocs/transition/transition_bloc.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // HttpOverrides.global = LFHttpOverrides();

    Bloc.observer = LFBlocObserver();

    await EasyLocalization.ensureInitialized();

    // FlutterError.onError ( to catch all unhandled-flutter-framework-errors )
    FlutterError.onError = (FlutterErrorDetails details) {
      Logging.e(':: Interceptor FlutterError onError');
      FlutterError.dumpErrorToConsole(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      Logging.e(':: Interceptor Platform Error: $error');
      return true;
    };

    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ko', 'KR'),
        ],
        path: 'packages/resource/assets/lang',
        fallbackLocale: const Locale('en', 'US'),
        child: const ExampleApp(),
      ),
    );
  }, (error, stackTrace) {
    // Zone ( to catch all unhandled-asynchronous-errors )
    Logging.e(':: Interceptor Zone Error : $error, StackTrace : $stackTrace');
  });
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LFLocalizations Config
    LFLocalizations.shared.config(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TransitionBloc(),
        ),
      ],
      child: BlocBuilder<TransitionBloc, TransitionState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Example App',
            // navigatorKey: GetIt.I.get<TransitionController>().navigatorKey,
            localizationsDelegates: [
              const CupertinoLocalizationsKoFixedDelegate(),
              ...context.localizationDelegates,
            ],
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            // navigatorObservers: [
            //   FirebaseAnalyticsObserver(analytics: analytics),
            // ],
            builder: (context, widget) {
              // ErrorWidget.builder = (errorDetails) {
              //   return BFRenderErrorPage(
              //     widget: widget,
              //     errorDetails: errorDetails,
              //   );
              // };
              if (widget != null) return widget;
              throw ('widget is null');
            },
            onGenerateRoute: (settings) {
              Logging.i('[onGenerateRoute]: $settings');
              final app = MaterialWithModalsPageRoute(
                // builder: (_) => App(Env.shared.platformPackage),
                builder: (_) => const App(),
                settings: settings,
              );
              switch (settings.name) {
                case '/':
                  return app;
              }
              return app;
            },
            // onUnknownRoute: (settings) => MaterialPageRoute(
            //   builder: (context) => BFUndefinedView(
            //     name: settings.name ?? '',
            //   ),
            // ),
            initialRoute: '/',
            // home: App(env: env),
          );
        },
      ),
    );
  }
}
