import 'package:flutter/material.dart';

import '../../../../configure/configure.dart';
import '../../../text/text.dart';

@Deprecated('Use LeafAlertDialog instead')
class LFDialogMessage extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const LFDialogMessage({
    super.key,
    this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = this.textStyle ??
        LFComponentConfigure.shared.alert?.messageStyle ??
        const TextStyle(fontSize: 16);

    return LFText(
      text ?? '',
      style: textStyle,
      maxLines: 5,
    );
  }
}
