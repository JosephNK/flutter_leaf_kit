import 'package:flutter/material.dart';
import 'package:flutter_leaf_component/leaf_component.dart';

class ChipScreen extends ScreenStatefulWidget {
  final String title;

  const ChipScreen({
    super.key,
    required this.title,
  });

  @override
  State<ChipScreen> createState() => _ChipScreenState();
}

class _ChipScreenState extends ScreenState<ChipScreen> {
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
            LFChip(
              text: 'Hello',
              selected: false,
            ),
            SizedBox(width: 10.0),
            LFChip(
              text: 'Hello',
              selected: true,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LFChips(
              direction: Axis.horizontal,
              items: const [
                LFDataItem(id: 'Hello', text: 'Hello'),
                LFDataItem(id: 'Hello', text: 'World'),
              ],
              values: const [
                LFDataItem(id: 'Hello', text: 'Hello'),
              ],
              onChanged: (values, value) {},
            ),
            const SizedBox(width: 10.0),
            LFChips(
              direction: Axis.vertical,
              items: const [
                LFDataItem(id: 'Travel', text: 'Travel'),
                LFDataItem(id: 'Dance', text: 'Dance'),
                LFDataItem(id: 'Fitness', text: 'Fitness'),
                LFDataItem(id: 'Reading', text: 'Reading'),
                LFDataItem(id: 'Photography', text: 'Photography'),
                LFDataItem(id: 'Music', text: 'Music'),
                LFDataItem(id: 'Movie', text: 'Movie'),
              ],
              values: const [
                LFDataItem(id: 'Dance', text: 'Dance'),
              ],
              onChanged: (values, value) {},
            ),
          ],
        )
      ],
    );
  }
}
