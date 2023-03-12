import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class DialogScreen extends ScreenStatefulWidget {
  final String title;

  const DialogScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends ScreenState<DialogScreen> {
  final List<LFDataItem> _checkboxItems = [
    const LFDataItem(id: '1', text: 'Hello'),
    const LFDataItem(id: '2', text: 'World'),
  ];
  List<LFDataItem> _selectedCheckboxItems = [];

  final List<LFDataItem> _radioItems = [
    const LFDataItem(id: '1', text: 'Hello'),
    const LFDataItem(id: '2', text: 'World'),
  ];
  LFDataItem? _selectedRadioItem;

  final List<LFDataItem> _chipItems = [
    const LFDataItem(id: '1', text: 'Hello'),
    const LFDataItem(id: '2', text: 'World'),
    const LFDataItem(id: '3', text: 'Nice'),
    const LFDataItem(id: '4', text: 'To'),
    const LFDataItem(id: '5', text: 'Meet'),
    const LFDataItem(id: '6', text: 'You'),
  ];
  List<LFDataItem> _selectedChipItems = [];

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: LFFlatButton(
            text: 'Show Alert',
            onPressed: () {
              LFAlertDialog.show(
                context,
                title: 'Title',
                message: 'Message',
                onCancel: () {},
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFFlatButton(
            text: 'Show CheckBox Picker Dialog',
            onPressed: () {
              LFCheckboxPickerDialog.show(
                context,
                items: _checkboxItems,
                values: _selectedCheckboxItems,
                title: 'CheckBox Picker',
                onOK: (values) {
                  setState(() {
                    _selectedCheckboxItems = values;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFFlatButton(
            text: 'Show Radio Picker Dialog',
            onPressed: () {
              LFRadioPickerDialog.show(
                context,
                items: _radioItems,
                value: _selectedRadioItem,
                title: 'Radio Picker',
                onOK: (value) {
                  setState(() {
                    _selectedRadioItem = value;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFFlatButton(
            text: 'Show Chip Picker Dialog',
            onPressed: () {
              LFChipPickerDialog.show(
                context,
                items: _chipItems,
                values: _selectedChipItems,
                title: 'Chip Picker',
                multiple: true,
                onOK: (values) {
                  setState(() {
                    _selectedChipItems = values;
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFFlatButton(
            text: 'Show Calendar Date Picker Dialog',
            onPressed: () {
              LFCalendarDatePickerDialog.show(
                context,
                pickerSelect: LFCalendarPickerSelect.start,
              );
            },
          ),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: LFFlatButton(
            text: 'Show Calendar Time Picker Dialog',
            onPressed: () {
              LFCalendarTimePickerDialog.show(
                context,
                pickerSelect: LFCalendarPickerSelect.start,
              );
            },
          ),
        ),
      ],
    );
  }
}
