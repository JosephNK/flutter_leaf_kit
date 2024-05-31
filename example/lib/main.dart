import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

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

    LoggingManager.shared.setup(PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 10, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: Platform.isAndroid, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false, // Should each log print contain a timestamp
    ));

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
        path: 'assets/translations',
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
    LFLocalizations.shared.config(context, locale: context.locale);

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
            theme: ThemeData(useMaterial3: true),
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
