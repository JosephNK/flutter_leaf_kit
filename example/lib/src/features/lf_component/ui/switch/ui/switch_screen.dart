import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class SwitchScreen extends ScreenStatefulWidget {
  final String title;

  const SwitchScreen({
    super.key,
    required this.title,
  });

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends ScreenState<SwitchScreen> {
  bool _onOffCupertino = true;
  bool _onOff = true;

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
    const activeTrackColor = Colors.red;
    const inactiveTrackColor = Colors.grey;
    const thumbColor = Colors.white;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetTile(
          title: 'LFSwitch (Cupertino)',
          child: LFSwitch(
            value: _onOffCupertino,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            isIOS: true,
            onChanged: (value) {
              setState(() {
                _onOffCupertino = value;
              });
            },
          ),
        ),
        const WidgetTile(
          title: 'LFSwitch (Cupertino)',
          child: LFSwitch(
            value: false,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            isIOS: true,
          ),
        ),
        WidgetTile(
          title: 'LFSwitch (Material)',
          child: LFSwitch(
            value: _onOff,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            isIOS: false,
            onChanged: (value) {
              setState(() {
                _onOff = value;
              });
            },
          ),
        ),
        const WidgetTile(
          title: 'LFSwitch (Material)',
          child: LFSwitch(
            value: false,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            isIOS: false,
          ),
        ),
      ],
    );
  }
}
