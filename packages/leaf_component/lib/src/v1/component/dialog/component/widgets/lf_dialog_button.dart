import 'package:flutter/material.dart';

import '../../../../configure/configure.dart';
import '../../../text/text.dart';

const kDefaultDialogButtonTextStyle = TextStyle(fontSize: 16);
const kDefaultDialogButtonPadding =
    EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0);

@Deprecated('Use LeafAlertDialog instead')
class LFDialogOKButton extends StatelessWidget {
  final bool autoPop;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const LFDialogOKButton({
    super.key,
    this.autoPop = true,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final text = this.text ?? LFComponentConfigure.shared.alert?.okText ?? 'OK';

    final okTextStyleValue = LFComponentConfigure.shared.alert?.okTextStyle;
    final okTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.okTextBackgroundColor;
    final okTextBorderColor =
        LFComponentConfigure.shared.alert?.okTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    final textStyle =
        this.textStyle ?? okTextStyleValue ?? kDefaultDialogButtonTextStyle;
    final backgroundColor =
        this.backgroundColor ?? okTextBackgroundColorValue ?? Colors.blueAccent;
    final borderColor = this.borderColor ?? okTextBorderColor;
    final padding =
        this.padding ?? buttonPadding ?? kDefaultDialogButtonPadding;

    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context, 'OK');
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          color: backgroundColor,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: padding,
        child: LFText(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }
}

@Deprecated('Use LeafAlertDialog instead')
class LFDialogCancelButton extends StatelessWidget {
  final bool autoPop;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const LFDialogCancelButton({
    super.key,
    this.autoPop = true,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final text =
        this.text ?? LFComponentConfigure.shared.alert?.cancelText ?? 'CANCEL';

    final cancelTextStyleValue =
        LFComponentConfigure.shared.alert?.cancelTextStyle;
    final cancelTextBackgroundColorValue =
        LFComponentConfigure.shared.alert?.cancelTextBackgroundColor;
    final cancelTextBorderColor =
        LFComponentConfigure.shared.alert?.cancelTextBorderColor;
    final buttonPadding = LFComponentConfigure.shared.alert?.buttonPadding;

    final textStyle =
        this.textStyle ?? cancelTextStyleValue ?? kDefaultDialogButtonTextStyle;
    final backgroundColor = this.backgroundColor ??
        cancelTextBackgroundColorValue ??
        Colors.grey.withValues(alpha: 0.5);
    final borderColor = this.borderColor ?? cancelTextBorderColor;
    final padding =
        this.padding ?? buttonPadding ?? kDefaultDialogButtonPadding;

    return GestureDetector(
      onTap: () async {
        if (autoPop) {
          Navigator.maybePop(context, 'CANCEL');
          await Future.delayed(const Duration(milliseconds: 100));
        }
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: borderColor != null ? Border.all(color: borderColor) : null,
          color: backgroundColor,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: padding,
        child: LFText(
          text,
          style: textStyle,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ),
    );
  }
}
