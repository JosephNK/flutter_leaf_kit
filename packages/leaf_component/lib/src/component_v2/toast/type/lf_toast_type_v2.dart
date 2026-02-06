import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

/// Toast display duration type.
enum LFToastTypeV2 {
  lengthShort,
  lengthLong,
}

extension LFToastTypeV2Ext on LFToastTypeV2 {
  Toast get value {
    switch (this) {
      case LFToastTypeV2.lengthShort:
        return Toast.LENGTH_SHORT;
      case LFToastTypeV2.lengthLong:
        return Toast.LENGTH_LONG;
    }
  }
}

/// Toast gravity (position) type.
enum LFToastGravityTypeV2 {
  top,
  center,
  bottom,
}

extension LFToastGravityTypeV2Ext on LFToastGravityTypeV2 {
  ToastGravity get value {
    switch (this) {
      case LFToastGravityTypeV2.top:
        return ToastGravity.TOP;
      case LFToastGravityTypeV2.center:
        return ToastGravity.CENTER;
      case LFToastGravityTypeV2.bottom:
        return ToastGravity.BOTTOM;
    }
  }
}

/// Toastification notification type.
enum LFToastNotificationTypeV2 {
  info,
  warning,
  success,
  error,
}

extension LFToastNotificationTypeV2Ext on LFToastNotificationTypeV2 {
  ToastificationType get value {
    switch (this) {
      case LFToastNotificationTypeV2.info:
        return ToastificationType.info;
      case LFToastNotificationTypeV2.warning:
        return ToastificationType.warning;
      case LFToastNotificationTypeV2.success:
        return ToastificationType.success;
      case LFToastNotificationTypeV2.error:
        return ToastificationType.error;
    }
  }
}

/// Toastification notification style.
enum LFToastNotificationStyleV2 {
  minimal,
  fillColored,
  flatColored,
  flat,
  simple,
}

extension LFToastNotificationStyleV2Ext on LFToastNotificationStyleV2 {
  ToastificationStyle get value {
    switch (this) {
      case LFToastNotificationStyleV2.minimal:
        return ToastificationStyle.minimal;
      case LFToastNotificationStyleV2.fillColored:
        return ToastificationStyle.fillColored;
      case LFToastNotificationStyleV2.flatColored:
        return ToastificationStyle.flatColored;
      case LFToastNotificationStyleV2.flat:
        return ToastificationStyle.flat;
      case LFToastNotificationStyleV2.simple:
        return ToastificationStyle.simple;
    }
  }
}
