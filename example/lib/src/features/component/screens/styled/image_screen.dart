import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ImageScreen extends LFScreenStatefulWidgetV2 {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends LFScreenStateV2<ImageScreen> {
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LFAppBarV2(title: LFAppBarTitleV2(text: 'Image'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Asset Image',
          children: [
            ShowcaseTile(
              label: 'From assets',
              child: LFAssetImageV2(
                uri: Uri.parse('assets/images/sample400x300.jpg'),
                width: 200,
                height: 150,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Network Image',
          children: [
            ShowcaseTile(
              label: 'Cached network image',
              child: LFCacheNetworkImageV2(
                url: 'https://picsum.photos/200/150',
                width: 200,
                height: 150,
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Circle Avatar',
          children: [
            ShowcaseTile(
              label: 'Different sizes',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LFCircleAvatarImageV2(
                    url: 'https://picsum.photos/100',
                    size: 20,
                  ),
                  LFCircleAvatarImageV2(
                    url: 'https://picsum.photos/100',
                    size: 30,
                  ),
                  LFCircleAvatarImageV2(
                    url: 'https://picsum.photos/100',
                    size: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
