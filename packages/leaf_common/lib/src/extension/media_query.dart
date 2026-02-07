part of '../index.dart';

extension MediaQueryDataHelper on MediaQueryData {
  bool isVisibleKeyboard(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }
}
