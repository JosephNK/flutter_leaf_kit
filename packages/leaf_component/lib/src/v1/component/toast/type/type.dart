part of '../toast.dart';

@Deprecated('Use LeafToast instead.')
enum LFToastType {
  lengthShort,
  lengthLong,
}

@Deprecated('Use LeafToast instead.')
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

@Deprecated('Use LeafToast instead.')
enum LFToastGravityType {
  top,
  center,
  bottom,
}

@Deprecated('Use LeafToast instead.')
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

@Deprecated('Use LeafToast instead.')
enum LFToastNotificationType {
  info,
  warning,
  success,
  error,
}

@Deprecated('Use LeafToast instead.')
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

@Deprecated('Use LeafToast instead.')
enum LFToastNotificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,
  simple,
}

@Deprecated('Use LeafToast instead.')
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
