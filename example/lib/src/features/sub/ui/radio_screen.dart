import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class RadioScreen extends ScreenStatefulWidget {
  final String title;

  const RadioScreen({
    super.key,
    required this.title,
  });

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends ScreenState<RadioScreen> {
  final _items = [
    const LFDataItem(id: '1', text: 'Hello', leading: Icon(Icons.add)),
    const LFDataItem(id: '2', text: 'World'),
  ];
  var _selectedItem01 = const LFDataItem(id: '1', text: 'Hello');
  var _selectedItem02 = const LFDataItem(id: '1', text: 'Hello');

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
            LFRadio(
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
            LFRadioGroups(
              direction: Axis.vertical,
              items: _items,
              value: _selectedItem01,
              onChanged: (item, checked) {
                setState(() {
                  _selectedItem01 = item;
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
            LFRadioGroups(
              direction: Axis.horizontal,
              items: _items,
              value: _selectedItem02,
              onChanged: (item, checked) {
                setState(() {
                  _selectedItem02 = item;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LFRadioGroups(
            direction: Axis.horizontal,
            items: _items,
            value: _selectedItem02,
            align: LFRadioAlign.right,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            runSpacing: 3.0,
            onChanged: (item, checked) {
              setState(() {
                _selectedItem02 = item;
              });
            },
          ),
        ),
      ],
    );
  }
}
