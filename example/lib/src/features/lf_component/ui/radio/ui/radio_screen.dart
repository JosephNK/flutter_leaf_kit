import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const WidgetTile(
            title: 'LFRadio',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LFRadio(
                  text: 'Hello',
                  value: true,
                ),
              ],
            ),
          ),
          WidgetTile(
            title: 'LFRadioGroups (Axis.vertical)',
            child: Row(
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
          ),
          WidgetTile(
            title: 'LFRadioGroups (Axis.horizontal)',
            child: Row(
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
          ),
          WidgetTile(
            title: 'LFRadioGroups (MainAxisAlignment.spaceBetween)',
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
      ),
    );
  }
}
