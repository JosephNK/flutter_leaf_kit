import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class CheckboxScreen extends ScreenStatefulWidget {
  final String title;

  const CheckboxScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LFCheckBox(
              text: 'Hello',
              value: true,
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
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
        const SizedBox(height: 20.0),
        Row(
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
        const SizedBox(height: 20.0),
        LFCheckboxGroups(
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
      ],
    );
  }
}
