part of '../dialog.dart';

/// CustomDialog
/// https://medium.com/@excogitatr/custom-dialog-in-flutter-d00e0441f1d5
///

class LFCheckboxPickerDialog {
  static Future show(
    BuildContext context, {
    required List<LFDataItem> items,
    List<LFDataItem>? values,
    String? title,
    ValueChanged<List<LFDataItem>>? onOK,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return _CheckBoxPickerContent(
          items: items,
          values: values,
          title: title,
          onOK: onOK,
        );
      },
    );
  }
}

class _CheckBoxPickerContent extends StatefulWidget {
  final List<LFDataItem> items;
  final List<LFDataItem>? values;
  final String? title;
  final ValueChanged<List<LFDataItem>>? onOK;

  const _CheckBoxPickerContent({
    required this.items,
    this.values,
    this.title,
    this.onOK,
  });

  @override
  State<_CheckBoxPickerContent> createState() => _CheckBoxPickerContentState();
}

class _CheckBoxPickerContentState extends State<_CheckBoxPickerContent> {
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
  void didUpdateWidget(covariant _CheckBoxPickerContent oldWidget) {
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
                child: LFCheckboxGroups(
                  direction: Axis.horizontal,
                  align: LFCheckBoxAlign.right,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  items: items,
                  values: _values,
                  runSpacing: 6.0,
                  onChanged: (items, item) {
                    setState(() {
                      _values = items;
                    });
                  },
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LFButton(
                  text: 'Close',
                  textColor: Colors.black54,
                  backgroundColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 8.0),
                LFButton(
                  text: 'OK',
                  textColor: Colors.blueAccent,
                  backgroundColor: Colors.transparent,
                  onTap: () {
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
