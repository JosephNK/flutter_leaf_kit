import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'leaf_console_output.dart';

class LeafLogging {
  static void d(dynamic message) {
    LeafLoggingManager.shared.logger?.d(message);
  }

  static void i(dynamic message) {
    LeafLoggingManager.shared.logger?.i(message);
  }

  static void w(dynamic message) {
    LeafLoggingManager.shared.logger?.w(message);
  }

  static void e(dynamic message) {
    LeafLoggingManager.shared.logger?.e(message);
  }

  static void printLong(dynamic message) {
    if (kDebugMode) {
      // https://nguyentk217.medium.com/print-large-strings-in-flutter-ffc63a14b92
      final RegExp pattern = RegExp(
        '.{1,800}',
      ); // 800 is the size of each chunk
      pattern
          .allMatches(message)
          .forEach((RegExpMatch match) => debugPrint(match.group(0)));
    }
  }
}

class LeafLoggingManager {
  static final LeafLoggingManager _instance = LeafLoggingManager._internal();
  static LeafLoggingManager get shared => _instance;
  LeafLoggingManager._internal() {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: Platform.isAndroid, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        dateTimeFormat:
            DateTimeFormat.none, // Should each log print contain a timestamp
      ),
      output: PlatformConsoleOutput(),
    );
  }

  Logger? logger;

  void setup(PrettyPrinter prettyPrinter) {
    logger = Logger(printer: prettyPrinter, output: PlatformConsoleOutput());
  }
}
