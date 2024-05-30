part of '../toast.dart';

enum LFToastType {
  lengthShort,
  lengthLong,
}

extension LFToastTypeExt on LFToastType {
  Toast get value {
    switch (this) {
      case LFToastType.lengthShort:
        return Toast.LENGTH_SHORT;
      case LFToastType.lengthLong:
        return Toast.LENGTH_LONG;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

enum LFToastGravityType {
  top,
  center,
  bottom,
}

extension LFToastGravityTypeExt on LFToastGravityType {
  ToastGravity get value {
    switch (this) {
      case LFToastGravityType.top:
        return ToastGravity.TOP;
      case LFToastGravityType.center:
        return ToastGravity.CENTER;
      case LFToastGravityType.bottom:
        return ToastGravity.BOTTOM;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

enum LFToastNotificationType {
  info,
  warning,
  success,
  error,
}

extension LFToastNotificationTypeExt on LFToastNotificationType {
  ToastificationType get value {
    switch (this) {
      case LFToastNotificationType.info:
        return ToastificationType.info;
      case LFToastNotificationType.warning:
        return ToastificationType.warning;
      case LFToastNotificationType.success:
        return ToastificationType.success;
      case LFToastNotificationType.error:
        return ToastificationType.error;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

enum LFToastNotificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,
  simple,
}

extension LFToastNotificationStyleExt on LFToastNotificationStyle {
  ToastificationStyle get value {
    switch (this) {
      case LFToastNotificationStyle.minimal:
        return ToastificationStyle.minimal;
      case LFToastNotificationStyle.fillColored:
        return ToastificationStyle.fillColored;
      case LFToastNotificationStyle.flatColored:
        return ToastificationStyle.flatColored;
      case LFToastNotificationStyle.flat:
        return ToastificationStyle.flat;
      case LFToastNotificationStyle.simple:
        return ToastificationStyle.simple;
    }
  }
}
