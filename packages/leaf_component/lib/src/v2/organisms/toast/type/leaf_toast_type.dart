import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

/// Toast display duration type.
enum LeafToastType { lengthShort, lengthLong }

extension LeafToastTypeExt on LeafToastType {
  Toast get value {
    switch (this) {
      case LeafToastType.lengthShort:
        return Toast.LENGTH_SHORT;
      case LeafToastType.lengthLong:
        return Toast.LENGTH_LONG;
    }
  }
}

/// Toast gravity (position) type.
enum LeafToastGravityType { top, center, bottom }

extension LeafToastGravityTypeExt on LeafToastGravityType {
  ToastGravity get value {
    switch (this) {
      case LeafToastGravityType.top:
        return ToastGravity.TOP;
      case LeafToastGravityType.center:
        return ToastGravity.CENTER;
      case LeafToastGravityType.bottom:
        return ToastGravity.BOTTOM;
    }
  }
}

/// Toastification notification type.
enum LeafToastNotificationType { info, warning, success, error }

extension LeafToastNotificationTypeExt on LeafToastNotificationType {
  ToastificationType get value {
    switch (this) {
      case LeafToastNotificationType.info:
        return ToastificationType.info;
      case LeafToastNotificationType.warning:
        return ToastificationType.warning;
      case LeafToastNotificationType.success:
        return ToastificationType.success;
      case LeafToastNotificationType.error:
        return ToastificationType.error;
    }
  }
}

/// Toastification notification style.
enum LeafToastNotificationStyle {
  minimal,
  fillColored,
  flatColored,
  flat,
  simple,
}

extension LeafToastNotificationStyleExt on LeafToastNotificationStyle {
  ToastificationStyle get value {
    switch (this) {
      case LeafToastNotificationStyle.minimal:
        return ToastificationStyle.minimal;
      case LeafToastNotificationStyle.fillColored:
        return ToastificationStyle.fillColored;
      case LeafToastNotificationStyle.flatColored:
        return ToastificationStyle.flatColored;
      case LeafToastNotificationStyle.flat:
        return ToastificationStyle.flat;
      case LeafToastNotificationStyle.simple:
        return ToastificationStyle.simple;
    }
  }
}
