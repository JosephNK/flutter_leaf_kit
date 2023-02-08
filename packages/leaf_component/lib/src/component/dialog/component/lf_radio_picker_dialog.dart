part of lf_dialog;

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

class LFRadioPickerDialog {
  static Future show(
    BuildContext context, {
    required List<LFDataItem> items,
    LFDataItem? value,
    String? title,
    ValueChanged<LFDataItem?>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _RadioPickerContent(
          items: items,
          value: value,
          title: title,
          onOK: onOK,
        );
      },
    );
  }
}

class _RadioPickerContent extends StatefulWidget {
  final List<LFDataItem> items;
  final LFDataItem? value;
  final String? title;
  final ValueChanged<LFDataItem?>? onOK;

  const _RadioPickerContent({
    Key? key,
    required this.items,
    this.value,
    this.title,
    this.onOK,
  }) : super(key: key);

  @override
  State<_RadioPickerContent> createState() => _RadioPickerContentState();
}

class _RadioPickerContentState extends State<_RadioPickerContent> {
  late LFDataItem? _value;

  @override
  void initState() {
    super.initState();

    final value = widget.value;
    _value = value;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _RadioPickerContent oldWidget) {
    if (oldWidget.value != widget.value) {
      final value = widget.value;
      setState(() {
        _value = value;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? '';
    final items = widget.items;
    final onOK = widget.onOK;

    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 4.0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isNotEmpty(title),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: LFText(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: SingleChildScrollView(
                child: LFRadioGroups(
                  direction: Axis.horizontal,
                  align: LFRadioAlign.right,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  items: items,
                  value: _value,
                  runSpacing: 6.0,
                  onChanged: (item, checked) {
                    setState(() {
                      _value = item;
                    });
                  },
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LFFlatButton(
                  text: 'Close',
                  textColor: Colors.black54,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8.0),
                LFFlatButton(
                  text: 'OK',
                  textColor: Colors.blueAccent,
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onOK?.call(_value);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
