import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class IndicatorScreen extends ScreenStatefulWidget {
  final String title;

  const IndicatorScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<IndicatorScreen> createState() => _IndicatorScreenState();
}

class _IndicatorScreenState extends ScreenState<IndicatorScreen> {
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
    final sizes = [
      LFIndicatorSize.small,
      LFIndicatorSize.medium,
      LFIndicatorSize.large,
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LFText('LFIndicator'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...sizes.map((size) {
              return LFIndicator(
                  padding: const EdgeInsets.all(8.0), size: size);
            }).toList(),
          ],
        ),
        const SizedBox(height: 30.0),
        const LFText('LFMaterialIndicator'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...sizes.map((size) {
              return LFMaterialIndicator(
                  padding: const EdgeInsets.all(8.0), size: size);
            }).toList(),
          ],
        ),
        const SizedBox(height: 30.0),
        const LFText('LFCupertinoIndicator'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...sizes.map((size) {
              return LFCupertinoIndicator(
                  padding: const EdgeInsets.all(8.0), size: size);
            }).toList(),
          ],
        ),
        const SizedBox(height: 30.0),
        const LFText('LFPageIndicator'),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LFPageIndicator(
              total: 5,
              current: 2.0,
              margin: EdgeInsets.all(18.0),
            ),
            LFPageIndicator(
              total: 5,
              current: 0.0,
              activeColor: Colors.pinkAccent,
              margin: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ],
    );
  }
}
