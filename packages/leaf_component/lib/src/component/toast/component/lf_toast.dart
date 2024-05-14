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

class LFToast {
  static Future<bool?> show(
    BuildContext context, {
    required String message,
    LFToastType toastType = LFToastType.lengthShort,
    LFToastGravityType toastGravityType = LFToastGravityType.bottom,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: toastType.value,
      gravity: toastGravityType.value,
      backgroundColor: backgroundColor ?? Colors.black87,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 16.0,
    );
  }
}
