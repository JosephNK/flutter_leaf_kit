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
    const trackColor = Colors.grey;
    const thumbColor = Colors.white;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LFSwitch(
              value: _onOffCupertino,
              activeTrackColor: activeTrackColor,
              trackColor: trackColor,
              thumbColor: thumbColor,
              isIOS: true,
              onChanged: (value) {
                setState(() {
                  _onOffCupertino = value;
                });
              },
            ),
            const LFSwitch(
              value: false,
              activeTrackColor: activeTrackColor,
              trackColor: trackColor,
              thumbColor: thumbColor,
              isIOS: true,
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LFSwitch(
              value: _onOff,
              activeTrackColor: activeTrackColor,
              trackColor: trackColor,
              thumbColor: thumbColor,
              isIOS: false,
              onChanged: (value) {
                setState(() {
                  _onOff = value;
                });
              },
            ),
            const LFSwitch(
              value: false,
              activeTrackColor: activeTrackColor,
              trackColor: trackColor,
              thumbColor: thumbColor,
              isIOS: false,
            ),
          ],
        ),
      ],
    );
  }
}
