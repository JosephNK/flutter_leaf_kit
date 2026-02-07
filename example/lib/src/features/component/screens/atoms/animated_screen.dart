import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../../../../common/widgets/showcase_scaffold.dart';
import '../../../../common/widgets/showcase_section.dart';
import '../../../../common/widgets/showcase_tile.dart';

class AnimatedScreen extends LeafScreenStatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends LeafScreenState<AnimatedScreen> {
  bool _bounce = false;
  bool _fade = false;
  bool _scale = false;
  bool _rotate = false;

  Widget _sampleBox(Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, Object? state) {
    return const LeafAppBar(title: LeafAppBarTitle(text: 'Animated'));
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    final colors = context.leafColors;

    return ShowcaseScaffold(
      children: [
        ShowcaseSection(
          title: 'Animated Widgets',
          children: [
            ShowcaseTile(
              label: 'Bouncing (tap to toggle)',
              child: GestureDetector(
                onTap: () => setState(() => _bounce = !_bounce),
                child: LeafBouncingAnimated(
                  value: _bounce,
                  child: _sampleBox(colors.primary),
                ),
              ),
            ),
            ShowcaseTile(
              label: 'Fade (tap to toggle)',
              child: GestureDetector(
                onTap: () => setState(() => _fade = !_fade),
                child: LeafFadeAnimated(
                  value: _fade,
                  child: _sampleBox(colors.secondary),
                ),
              ),
            ),
            ShowcaseTile(
              label: 'Scale (tap to toggle)',
              child: GestureDetector(
                onTap: () => setState(() => _scale = !_scale),
                child: LeafScaleAnimated(
                  value: _scale,
                  child: _sampleBox(colors.error),
                ),
              ),
            ),
            ShowcaseTile(
              label: 'Rotate (tap to toggle)',
              child: GestureDetector(
                onTap: () => setState(() => _rotate = !_rotate),
                child: LeafRotateAnimated(
                  value: _rotate,
                  child: _sampleBox(colors.success),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
