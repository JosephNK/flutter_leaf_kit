import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

const bool _kReleaseMode = kReleaseMode;

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
class PlatformConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (_kReleaseMode || !Platform.isIOS) {
      event.lines.forEach(debugPrint);
    } else {
      // 여러 줄을 개별 developer.log()로 호출하면
      // 다른 로그(curl 등)가 사이에 끼어들어 순서가 꼬일 수 있으므로
      // 하나의 호출로 합쳐서 출력
      developer.log(event.lines.join('\n'));
    }
  }
}
