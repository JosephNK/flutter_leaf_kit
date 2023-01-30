import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AnimationScreen extends ScreenStatefulWidget {
  final String title;

  const AnimationScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends ScreenState<AnimationScreen> {
  late LFRotateAnimationController _rotateController;
  late LFFadeAnimationController _fadeController;
  late LFExpandAnimationController _expandController;
  late LFBouncingAnimationController _bouncingController;
  late LFScaleAnimationController _scaleController;

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
      autoAnimation: true,
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
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? lstate) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          LFScaleAnimated(
            controller: _scaleController,
            child: const Center(
              child: Icon(Icons.backpack, size: 50.0),
            ),
          ),
          const SizedBox(height: 10.0),
          LFRoundedButton(
            text: 'Scale',
            onPressed: () async {
              if (_scaleController.status == LFAnimationStatus.forward) {
                _scaleController.reverse();
              } else {
                _scaleController.forward();
              }
            },
          ),
          const SizedBox(height: 10.0),
          LFBouncingAnimated(
            controller: _bouncingController,
            child: const Center(
              child: Icon(Icons.access_alarm, size: 50.0),
            ),
          ),
          const SizedBox(height: 10.0),
          LFRoundedButton(
            text: 'Bouncing',
            onPressed: () async {
              await _bouncingController.forward();
              await _bouncingController.reverse();
            },
          ),
          const SizedBox(height: 10.0),
          LFExpandAnimated(
            controller: _expandController,
            child: const Center(
              child: Icon(Icons.access_alarm, size: 45.0),
            ),
          ),
          const SizedBox(height: 10.0),
          LFRoundedButton(
            text: 'Expand',
            onPressed: () {
              if (_expandController.status == LFAnimationStatus.forward) {
                _expandController.reverse();
                return;
              }
              _expandController.forward();
            },
          ),
          const SizedBox(height: 10.0),
          LFFadeAnimated(
            controller: _fadeController,
            child: const Icon(Icons.account_balance, size: 45.0),
          ),
          const SizedBox(height: 10.0),
          LFRoundedButton(
            text: 'Fade',
            onPressed: () {
              if (_fadeController.status == LFAnimationStatus.repeat) {
                _fadeController.stop();
                return;
              }
              _fadeController.repeat();
            },
          ),
          const SizedBox(height: 10.0),
          LFRotateAnimated(
            controller: _rotateController,
            child: const Icon(Icons.rotate_right, size: 45.0),
          ),
          const SizedBox(height: 10.0),
          LFRoundedButton(
            text: 'Rotate',
            onPressed: () {
              if (_rotateController.status == LFAnimationStatus.repeat) {
                _rotateController.forwardWithStop();
                return;
              }
              _rotateController.repeat();
            },
          ),
        ],
      ),
    );
  }
}
