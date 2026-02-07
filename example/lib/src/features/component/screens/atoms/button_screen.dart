import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class ButtonScreen extends LeafScreenStatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends LeafScreenState<ButtonScreen> {
  bool _loading = false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Button'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Basic Button',
          children: [
            ShowcaseTile(
              label: 'Default',
              child: LeafButton(text: 'Tap me', onTap: () {}),
            ),
            ShowcaseTile(
              label: 'Disabled',
              child: LeafButton(text: 'Disabled', disabled: true),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Custom Styles',
          children: [
            ShowcaseTile(
              label: 'Custom colors',
              child: LeafButton(
                text: 'Custom',
                backgroundColor: colors.secondary,
                foregroundColor: colors.onSecondary,
                onTap: () {},
              ),
            ),
            ShowcaseTile(
              label: 'With leading icon',
              child: LeafButton(
                text: 'Download',
                leading: const Icon(Icons.download, size: 18),
                onTap: () {},
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Loading State',
          children: [
            ShowcaseTile(
              label: 'Toggle loading',
              child: LeafButton(
                text: 'Submit',
                loading: _loading,
                onTap: () {
                  setState(() => _loading = true);
                  Future.delayed(const Duration(seconds: 2), () {
                    if (mounted) setState(() => _loading = false);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
