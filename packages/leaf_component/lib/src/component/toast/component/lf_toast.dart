part of '../toast.dart';

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
    Toastification().show(
      context: context, // optional if you use ToastificationWrapper
      title: Text('Hello, world!'),
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
    );

    return Future.value(true);

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
