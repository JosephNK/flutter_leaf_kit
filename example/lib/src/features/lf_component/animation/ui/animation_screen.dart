import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AnimationScreen extends ScreenStatefulWidget {
  final String title;

  const AnimationScreen({
    super.key,
    required this.title,
  });

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends ScreenState<AnimationScreen> {
  late LFRotateAnimationController _rotateController;
  late LFFadeAnimationController _fadeController;
  late LFExpandAnimationController _expandController;
  late LFBouncingAnimationController _bouncingController;
  late LFScaleAnimationController _scaleController;

  bool _expand = true;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    _rotateController = LFRotateAnimationController(
      autoAnimation: false,
      repeatCount: -1,
      duration: const Duration(milliseconds: 1000),
      degree: pi * 2,
    );

    _fadeController = LFFadeAnimationController(
      autoAnimation: false,
      repeatCount: -1,
      duration: const Duration(milliseconds: 1000),
      isDisappear: false,
    );

    _expandController = LFExpandAnimationController(
      autoAnimation: true,
      repeatCount: -1,
      duration: const Duration(milliseconds: 1000),
    );

    _bouncingController = LFBouncingAnimationController(
      autoAnimation: true,
      repeatCount: -1,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleController = LFScaleAnimationController(
      autoAnimation: false,
      repeatCount: -1,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _fadeController.dispose();
    _expandController.dispose();
    _bouncingController.dispose();
    _scaleController.dispose();

    super.dispose();
  }

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Scale
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFScaleAnimated(
                  controller: _scaleController,
                  child: const Center(
                    child: Icon(Icons.backpack, size: 45.0),
                  ),
                ),
                LFButton(
                  text: 'Scale',
                  onTap: () async {
                    if (_scaleController.status == LFAnimationStatus.forward) {
                      _scaleController.reverse();
                    } else {
                      _scaleController.forward();
                    }
                  },
                ),
              ],
            ),

            /// Bouncing
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFBouncingAnimated(
                  controller: _bouncingController,
                  child: const Center(
                    child: Icon(Icons.access_alarm, size: 50.0),
                  ),
                ),
                LFButton(
                  text: 'Bouncing',
                  onTap: () async {
                    await _bouncingController.forward();
                    await _bouncingController.reverse();
                  },
                ),
              ],
            ),

            /// Expand
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFExpandAnimated(
                  controller: _expandController,
                  child: const Center(
                    child: Icon(Icons.access_alarm, size: 45.0),
                  ),
                ),
                LFButton(
                  text: 'Expand',
                  onTap: () {
                    if (_expandController.status == LFAnimationStatus.forward) {
                      _expandController.reverse();
                      return;
                    }
                    _expandController.forward();
                  },
                ),
              ],
            ),

            /// Expand (Value)
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFExpandAnimated(
                  value: _expand,
                  duration: const Duration(milliseconds: 550),
                  child: const Center(
                    child: Icon(Icons.access_alarm, size: 45.0),
                  ),
                ),
                LFButton(
                  text: 'Expand (Value)',
                  onTap: () async {
                    setState(() => _expand = !_expand);
                  },
                ),
              ],
            ),

            /// Fade
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFFadeAnimated(
                  controller: _fadeController,
                  child: const Icon(Icons.account_balance, size: 45.0),
                ),
                LFButton(
                  text: 'Fade',
                  onTap: () {
                    if (_fadeController.status == LFAnimationStatus.forward) {
                      _fadeController.reverse();
                      return;
                    }
                    _fadeController.forward();
                  },
                ),
              ],
            ),

            /// Rotate
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LFRotateAnimated(
                  controller: _rotateController,
                  child: const Icon(Icons.rotate_right, size: 45.0),
                ),
                LFButton(
                  text: 'Rotate (Repeat)',
                  onTap: () {
                    if (_rotateController.status == LFAnimationStatus.repeat) {
                      _rotateController.forwardWithStop();
                      return;
                    }
                    _rotateController.repeat();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
