import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class DialogScreen extends ScreenStatefulWidget {
  final String title;

  const DialogScreen({
    super.key,
    required this.title,
  });

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
  LFDataItem _selectedRadioItem = const LFDataItem(id: '1', text: 'Hello');

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
    return Container(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetTile(
              title: 'Alert Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Alert',
                  onTap: () {
                    LFAlertDialog.show(
                      context,
                      title: 'Title',
                      message: 'Message',
                      visibleCloseButton: true,
                      expandableButton: true,
                    );
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'Confirm Alert Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Confirm Alert',
                  onTap: () {
                    LFAlertDialog.confirm(
                      context,
                      title: 'Title',
                      message: 'Message',
                    );
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'CheckBox Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show CheckBox Picker Dialog',
                  onTap: () {
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
            ),
            WidgetTile(
              title: 'Radio Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Radio Picker Dialog',
                  onTap: () {
                    LFRadioPickerDialog.confirm(
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
            ),
            WidgetTile(
              title: 'Chip Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Chip Picker Dialog',
                  onTap: () {
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
            ),
            WidgetTile(
              title: 'Calendar Between Date Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Calendar Between Date Picker Dialog',
                  onTap: () {
                    LFCalendarBetweenDatePickerDialog.show(
                      context,
                      pickerSelect: LFCalendarBetweenPickerSelect.start,
                      // isLunar: true,
                      // isAllDay: true,
                    );
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'Calendar Between Time Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Calendar Between Time Picker Dialog',
                  onTap: () {
                    LFCalendarBetweenTimePickerDialog.show(
                      context,
                      pickerSelect: LFCalendarBetweenPickerSelect.start,
                    );
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'Calendar Date Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Calendar Date Picker Dialog',
                  onTap: () {
                    LFCalendarDatePickerDialog.show(
                      context,
                      onOK: (dateTime) {
                        debugPrint('Selected dateTime: $dateTime');
                      },
                    );
                  },
                ),
              ),
            ),
            WidgetTile(
              title: 'Calendar Time Picker Dialog',
              child: Center(
                child: LFButton(
                  text: 'Show Calendar Time Picker Dialog',
                  onTap: () {
                    LFCalendarTimePickerDialog.show(
                      context,
                      onOK: (dateTime) {
                        debugPrint('Selected dateTime: $dateTime');
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
