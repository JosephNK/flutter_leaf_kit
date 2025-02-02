import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AccordionScreen extends ScreenStatefulWidget {
  final String title;

  const AccordionScreen({
    super.key,
    required this.title,
  });

  @override
  State<AccordionScreen> createState() => _AccordionScreenState();
}

class _AccordionScreenState extends ScreenState<AccordionScreen> {
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
    return LFAccordion<int>(
      items: [
        LFAccordionItem(section: 'Section 01', subtitle: 'Hello', data: 1),
        LFAccordionItem(section: 'Section 02', data: 2),
        LFAccordionItem(section: 'Section 03', data: 3),
        LFAccordionItem(section: 'Section 04', data: 4),
        LFAccordionItem(section: 'Section 05', data: 5),
      ],
      itemBuilder: (context, index, item) {
        return Row(
          children: [
            Expanded(
              child: LFText(
                'index: $index, item: ${item.toString()} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque bibendum eget lorem ut feugiat. Donec aliquam rhoncus mi sit amet efficitur. In quis luctus orci. Morbi elementum faucibus enim, eget convallis metus. Nulla varius enim porttitor, sodales felis in, scelerisque lectus. Nam enim elit, ultricies eu lacus et, hendrerit sodales ex. Ut non vehicula nisi. Cras at erat nec erat vestibulum hendrerit eu ac erat. Nam quis sagittis nunc',
                maxLines: 100,
              ),
            )
          ],
        );
      },
    );
  }
}
