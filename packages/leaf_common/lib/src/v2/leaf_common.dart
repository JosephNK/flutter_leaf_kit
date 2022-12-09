library lf_common;

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quiver/strings.dart';

import 'logger/console_output.dart';

part 'bloc/lf_bloc_observer.dart';
part 'bloc/lf_bloc_screen_consumer.dart';
part 'datetime/datetime.dart';
part 'env/env.dart';
part 'extension/datetimes.dart';
part 'extension/lists.dart';
part 'extension/numbers.dart';
part 'extension/strings_date.dart';
part 'logger/logging.dart';
part 'navigation/navigation.dart';
