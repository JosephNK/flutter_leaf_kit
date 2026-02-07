import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class RatingBarScreen extends LFScreenStatefulWidgetV2 {
  const RatingBarScreen({super.key});

  @override
  State<RatingBarScreen> createState() => _RatingBarScreenState();
}

class _RatingBarScreenState extends LFScreenStateV2<RatingBarScreen> {
  double _rating = 3.5;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Rating Bar'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Rating',
          children: [
            ShowcaseTile(
              label: 'Half rating (${_rating.toStringAsFixed(1)})',
              child: LFRatingBarV2(
                itemCount: 5,
                initialRating: _rating,
                allowHalfRating: true,
                onRatingUpdate: (v) => setState(() => _rating = v),
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Variants',
          children: [
            ShowcaseTile(
              label: 'Read-only',
              child: LFRatingBarV2(
                itemCount: 5,
                initialRating: 4.0,
                ignoreGestures: true,
                onRatingUpdate: (_) {},
              ),
            ),
            ShowcaseTile(
              label: 'Small size',
              child: LFRatingBarV2(
                itemCount: 5,
                initialRating: 3.0,
                itemSize: 20,
                onRatingUpdate: (_) {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
