import 'package:logger/logger.dart';

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

  var logger = Logger();
}
