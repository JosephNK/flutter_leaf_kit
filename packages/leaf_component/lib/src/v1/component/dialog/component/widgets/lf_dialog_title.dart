import 'package:flutter/material.dart';

import '../../../../configure/configure.dart';
import '../../../text/text.dart';

@Deprecated('Use LeafAlertDialog instead')
class LFDialogTitle extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const LFDialogTitle({super.key, this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        this.textStyle ??
        LFComponentConfigure.shared.alert?.titleStyle ??
        const TextStyle(fontSize: 18);

    return LFText(text ?? '', style: textStyle, maxLines: 2);
  }
}
