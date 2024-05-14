part of '../dialog.dart';

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

class LFChipPickerDialog {
  static Future show(
    BuildContext context, {
    required List<LFDataItem> items,
    List<LFDataItem>? values,
    String? title,
    bool multiple = true,
    ValueChanged<List<LFDataItem>>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _ChipPickerContent(
          items: items,
          values: values,
          title: title,
          multiple: multiple,
          onOK: onOK,
        );
      },
    );
  }
}

class _ChipPickerContent extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final String? title;
  final bool multiple;
  final ValueChanged<List<LFDataItem>>? onOK;

  const _ChipPickerContent({
    required this.items,
    this.values,
    this.title,
    this.multiple = true,
    this.onOK,
  });

  @override
  State<_ChipPickerContent> createState() => _ChipPickerContentState();
}

class _ChipPickerContentState extends State<_ChipPickerContent> {
  List<LFDataItem>? _values;

  @override
  void initState() {
    super.initState();

    _values = List<LFDataItem>.from(widget.values ?? []);
  }

  @override
  void dispose() {
    _values = null;

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ChipPickerContent oldWidget) {
    if (oldWidget.values != widget.values) {
      final values = List<LFDataItem>.from(widget.values ?? []);
      setState(() {
        _values = values;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title ?? '';
    final multiple = widget.multiple;
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: LFChips(
                    direction: Axis.horizontal,
                    items: items,
                    values: _values,
                    multiple: multiple,
                    onChanged: (values, value) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),
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
                    onOK?.call(_values ?? []);
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
