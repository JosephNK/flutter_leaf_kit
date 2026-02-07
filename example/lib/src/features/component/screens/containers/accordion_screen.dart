import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';

class AccordionScreen extends LFScreenStatefulWidgetV2 {
  const AccordionScreen({super.key});

  @override
  State<AccordionScreen> createState() => _AccordionScreenState();
}

class _AccordionScreenState extends LFScreenStateV2<AccordionScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Accordion'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.lfTypography;
    final spacing = context.lfSpacing;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Expand',
          children: [
            LFAccordionV2<String>(
              items: [
                LFAccordionItemV2(
                  title: 'Section 1',
                  subtitle: 'Tap to expand',
                  data: 'Content for section 1',
                ),
                LFAccordionItemV2(
                  title: 'Section 2',
                  subtitle: 'Tap to expand',
                  data: 'Content for section 2',
                ),
                LFAccordionItemV2(
                  title: 'Section 3',
                  subtitle: 'Tap to expand',
                  data: 'Content for section 3',
                ),
              ],
              itemBuilder: (context, index, data) {
                return Padding(
                  padding: EdgeInsets.all(spacing.xl),
                  child: Text(data, style: typography.bodyMedium),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
