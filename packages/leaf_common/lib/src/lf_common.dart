library lf_common;

import 'dart:io';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart'
    show SynchronousFuture, kDebugMode, kIsWeb;
import 'package:klc/klc.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quiver/strings.dart';

import 'logger/console_output.dart';
import 'notification_center/src/dart_notification_center.dart';

export 'notification_center/src/dart_notification_center.dart';

part 'datetime/datetime.dart';
part 'datetime/extension/datetime_ext.dart';
part 'datetime/extension/string_date_ext.dart';
part 'env/env.dart';
part 'extension/lists.dart';
part 'extension/numbers.dart';
part 'localizations/cupertino_localizations_ko.dart';
part 'localizations/localizations.dart';
part 'logger/logging.dart';
part 'notification_center/notification_center.dart';
part 'number/number.dart';
part 'util/util.dart';
