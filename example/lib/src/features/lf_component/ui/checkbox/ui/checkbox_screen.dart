import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class CheckboxScreen extends ScreenStatefulWidget {
  final String title;

  const CheckboxScreen({
    super.key,
    required this.title,
  });

  @override
  State<CheckboxScreen> createState() => _CheckboxScreenState();
}

class _CheckboxScreenState extends ScreenState<CheckboxScreen> {
  final _items = [
    const LFDataItem(id: '1', text: 'Hello', leading: Icon(Icons.ac_unit)),
    const LFDataItem(id: '2', text: 'World'),
  ];
  var _selectedItems01 = [const LFDataItem(id: '1', text: 'Hello')];
  var _selectedItems02 = [const LFDataItem(id: '1', text: 'Hello')];

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const WidgetTile(
            title: 'Checkbox',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LFCheckBox(
                  text: 'Hello',
                  value: true,
                ),
              ],
            ),
          ),
          WidgetTile(
            title: 'LFCheckboxGroups (Axis.vertical)',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LFCheckboxGroups(
                  direction: Axis.vertical,
                  items: _items,
                  values: _selectedItems01,
                  onChanged: (items, item) {
                    setState(() {
                      _selectedItems01 = items;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetTile(
            title: 'LFCheckboxGroups (Axis.horizontal)',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LFCheckboxGroups(
                  direction: Axis.horizontal,
                  items: _items,
                  values: _selectedItems02,
                  onChanged: (items, item) {
                    setState(() {
                      _selectedItems02 = items;
                    });
                  },
                ),
              ],
            ),
          ),
          WidgetTile(
            title: 'LFCheckboxGroups (MainAxisAlignment.spaceBetween)',
            child: LFCheckboxGroups(
              direction: Axis.horizontal,
              items: _items,
              values: _selectedItems02,
              align: LFCheckBoxAlign.right,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              runSpacing: 4.0,
              onChanged: (items, item) {
                setState(() {
                  _selectedItems02 = items;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
