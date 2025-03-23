import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class PickerScreen extends ScreenStatefulWidget {
  final String title;

  const PickerScreen({
    super.key,
    required this.title,
  });

  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends ScreenState<PickerScreen> {
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
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WidgetTile(
            title: 'TimePicker',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LFTimePicker(
                  onChanged: (time) {
                    print('time: $time');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
