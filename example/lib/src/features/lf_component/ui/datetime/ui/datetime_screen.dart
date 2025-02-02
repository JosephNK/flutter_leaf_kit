import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class DateTimeScreen extends ScreenStatefulWidget {
  final String title;

  const DateTimeScreen({
    super.key,
    required this.title,
  });

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends ScreenState<DateTimeScreen> {
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
    const dateTZString =
        '2025-01-26T17:36:29.209Z'; // => 2025년 1월 27일 오전 2:36:29
    final displayDate = LFDate.parseFromDateTime(
            LFDate.parseFromString(dateTZString, isUtc: true).toLocal())
        .format('yyyy-MM-dd hh:mm:ss');
    debugPrint('displayDate: $displayDate'); // displayDate: 2025-01-27 02:36:29

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetTile(
          title: 'DateTime',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LFText(
                'DATA\n2025-01-26T17:36:29.209Z => 2025년 1월 27일 오전 2:36:29',
              ),
              LFText(
                'Result\n2025-01-26T17:36:29.209Z => $displayDate',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
