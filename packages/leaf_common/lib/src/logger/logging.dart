part of '../lf_common.dart';

class Logging {
  static void d(dynamic message) {
    LoggingManager.shared.logger.d(message);
  }

  static void i(dynamic message) {
    LoggingManager.shared.logger.i(message);
  }

  static void w(dynamic message) {
    LoggingManager.shared.logger.w(message);
  }

  static void e(dynamic message) {
    LoggingManager.shared.logger.e(message);
  }
}

class LoggingManager {
  static final LoggingManager _instance = LoggingManager._internal();

  static LoggingManager get shared => _instance;

  LoggingManager._internal();

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: Platform.isAndroid, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false, // Should each log print contain a timestamp
    ),
    output: PlatformConsoleOutput(),
  );
}
