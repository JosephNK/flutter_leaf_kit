part of '../lf_common.dart';

extension MediaQueryDataHelper on MediaQueryData {
  bool isVisibleKeyboard(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }
}
