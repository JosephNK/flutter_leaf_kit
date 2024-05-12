part of '../lf_common.dart';

class Logging {
  static void d(dynamic message) {
    LoggingManager.shared.logger?.d(message);
  }

  static void i(dynamic message) {
    LoggingManager.shared.logger?.i(message);
  }

  static void w(dynamic message) {
    LoggingManager.shared.logger?.w(message);
  }

  static void e(dynamic message) {
    LoggingManager.shared.logger?.e(message);
  }

  static void printLong(dynamic message) {
    if (kDebugMode) {
      // https://nguyentk217.medium.com/print-large-strings-in-flutter-ffc63a14b92
      final RegExp pattern =
          RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern
          .allMatches(message)
          .forEach((RegExpMatch match) => debugPrint(match.group(0)));
    }
  }
}

class LoggingManager {
  static final LoggingManager _instance = LoggingManager._internal();
  static LoggingManager get shared => _instance;
  LoggingManager._internal() {
    logger = Logger(
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

  Logger? logger;

  void setup(PrettyPrinter prettyPrinter) {
    logger = Logger(
      printer: prettyPrinter,
      output: PlatformConsoleOutput(),
    );
  }
}
