library leaf_firebase;

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:leaf_common/leaf_common.dart';
import 'package:leaf_data/leaf_data.dart';

export 'package:firebase_core/firebase_core.dart' show FirebaseApp;
export 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;

part 'src/firebase.dart';
