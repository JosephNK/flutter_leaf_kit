part of '../dialog.dart';

@Deprecated('Use LFAlertDialogV2 instead')
typedef LFCalendarTimePickerOnOK = Function(DateTime dateTime);

@Deprecated('Use LFAlertDialogV2 instead')
class LFCalendarTimePickerDialog {
  static Future show(
    BuildContext context, {
    DateTime? time,
    Color? activeColor,
    String? okText,
    TextStyle? okTextStyle,
    Color? okTextBackgroundColor,
    Color? okTextBorderColor,
    EdgeInsets? okTextPadding,
    LFCalendarTimePickerOnOK? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CalendarTimePickerContent(
          time: time,
          okText: okText,
          okTextStyle: okTextStyle,
          okTextBackgroundColor: okTextBackgroundColor,
          okTextBorderColor: okTextBorderColor,
          okTextPadding: okTextPadding,
          onOK: onOK,
        );
      },
    );
  }
}

class _CalendarTimePickerContent extends StatefulWidget {
  final DateTime? time;
  final String? okText;
  final TextStyle? okTextStyle;
  final Color? okTextBackgroundColor;
  final Color? okTextBorderColor;
  final EdgeInsets? okTextPadding;
  final LFCalendarTimePickerOnOK? onOK;

  const _CalendarTimePickerContent({
    this.time,
    this.okText,
    this.okTextStyle,
    this.okTextBackgroundColor,
    this.okTextBorderColor,
    this.okTextPadding,
    this.onOK,
  });

  @override
  State<_CalendarTimePickerContent> createState() =>
      _CalendarTimePickerContentState();
}

class _CalendarTimePickerContentState
    extends State<_CalendarTimePickerContent> {
  late DateTime _time;
  late DateTime _defaultTime;

  @override
  void initState() {
    super.initState();

    _time = widget.time ?? LFDate.now().dateTime;
    _defaultTime = _time;
  }

  @override
  Widget build(BuildContext context) {
    final okTextStyle = widget.okTextStyle;
    final okTextBackgroundColor = widget.okTextBackgroundColor;
    final okTextBorderColor = widget.okTextBorderColor;
    final okTextPadding = widget.okTextPadding;
    final okText = widget.okText;

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// DatePicker
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                initialDateTime: _defaultTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (value) {
                  _updateSelectTime(value);
                },
              ),
            ),

            /// OK Button
            Row(
              children: [
                Expanded(
                  child: LFDialogOKButton(
                    autoPop: false,
                    text: okText,
                    textStyle: okTextStyle,
                    backgroundColor: okTextBackgroundColor,
                    borderColor: okTextBorderColor,
                    padding: okTextPadding,
                    onPressed: () {
                      _onCallBackOK(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _updateSelectTime(DateTime? selectedTime) {
    if (selectedTime == null) return;
    final time = selectedTime;
    setState(() {
      _time = time;
    });
  }

  void _onCallBackOK(BuildContext context) {
    late DateTime time;

    time = _time;

    widget.onOK?.call(time);

    Navigator.of(context).pop();
  }
}
