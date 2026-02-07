import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../common/widgets/showcase_scaffold.dart';
import '../../common/widgets/showcase_section.dart';
import '../../common/widgets/showcase_tile.dart';

class PhotoScreen extends LFScreenStatefulWidgetV2 {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends LFScreenStateV2<PhotoScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Photo'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final typography = context.lfTypography;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Photo Components',
          children: [
            ShowcaseTile(
              label: 'Requires permission',
              child: Text(
                'LFPhotoAlbumV2 and LFPhotoListViewV2 require '
                'photo library permission. These components provide:\n\n'
                '- Album selection\n'
                '- Photo grid with multi-select\n'
                '- LRU cache for thumbnails\n\n'
                'Grant photo access to use these components.',
                style: typography.bodyMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
