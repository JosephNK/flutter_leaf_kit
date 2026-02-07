import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';

class AccordionScreen extends LeafScreenStatefulWidget {
  const AccordionScreen({super.key});

  @override
  State<AccordionScreen> createState() => _AccordionScreenState();
}

class _AccordionScreenState extends LeafScreenState<AccordionScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Accordion'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.leafTypography;
    final spacing = context.leafSpacing;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Single Expand',
          children: [
            LeafAccordion<String>(
              items: [
                LeafAccordionItem(
                  title: 'Section 1',
                  subtitle: 'Tap to expand',
                  data: 'Content for section 1',
                ),
                LeafAccordionItem(
                  title: 'Section 2',
                  subtitle: 'Tap to expand',
                  data: 'Content for section 2',
                ),
                LeafAccordionItem(
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
