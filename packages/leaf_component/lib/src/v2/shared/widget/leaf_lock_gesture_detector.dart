import 'dart:async';

import 'package:flutter/material.dart';

import 'leaf_inkwell.dart';

/// Builder for a custom loading indicator within [LeafLockGestureDetector].
typedef LeafLockGestureDetectorOnLoaderBuilder = Widget Function();

/// A gesture detector that locks taps for a brief duration to prevent
/// accidental double taps (debouncing).
///
/// Supports loading, disabled, and force-lock states.
/// Optionally wraps the child in [LeafInkWell] for Material ripple.
///
/// Standalone V2 version — no dependency on V1 or `LFIndicator`.
class LeafLockGestureDetector extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool forceLock;
  final bool loading;
  final bool showLoading;
  final bool disabled;
  final BoxDecoration? decoration;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool enabledInkWell;
  final LeafLockGestureDetectorOnLoaderBuilder? onLoaderBuilder;
  final VoidCallback? onTap;

  const LeafLockGestureDetector({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.forceLock = false,
    this.loading = false,
    this.showLoading = true,
    this.disabled = false,
    this.decoration,
    this.margin,
    this.padding,
    this.enabledInkWell = true,
    this.onLoaderBuilder,
    this.onTap,
  });

  @override
  State<LeafLockGestureDetector> createState() =>
      _LeafLockGestureDetectorState();
}

class _LeafLockGestureDetectorState extends State<LeafLockGestureDetector> {
  Timer? _timer;
  bool _lock = false;
  bool _forceLock = false;
  bool _loading = false;
  bool _disabled = false;

  @override
  void initState() {
    super.initState();
    _forceLock = widget.forceLock;
    _loading = widget.loading;
    _disabled = widget.disabled;
  }

  @override
  void dispose() {
    _stopLockTimer();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LeafLockGestureDetector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.forceLock != widget.forceLock) {
      _forceLock = widget.forceLock;
    }
    if (oldWidget.loading != widget.loading) {
      setState(() {
        _loading = widget.loading;
      });
    }
    if (oldWidget.disabled != widget.disabled) {
      setState(() {
        _disabled = widget.disabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    Widget? loadingWidget = widget.onLoaderBuilder?.call();

    Clip clipBehavior = Clip.hardEdge;
    List<Positioned> positionedWidgets = [];
    if (child is Stack) {
      clipBehavior = child.clipBehavior;
      positionedWidgets = child.children
          .map((e) => e is Positioned ? e : null)
          .nonNulls
          .toList();
      child = Stack(
        clipBehavior: clipBehavior,
        children: [
          ...child.children.map((e) => e is! Positioned ? e : null).nonNulls,
        ],
      );
    }

    final margin = widget.margin;
    final decoration = widget.decoration;
    final decBorderRadius = decoration?.borderRadius;
    final onTap = widget.onTap;

    final childWidget = Stack(
      alignment: Alignment.center,
      clipBehavior: clipBehavior,
      children: [
        Container(padding: widget.padding, child: child),
        Positioned.fill(
          child: Visibility(
            visible: _loading && widget.showLoading,
            child: Center(
              child:
                  loadingWidget ??
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
            ),
          ),
        ),
        ...positionedWidgets,
      ],
    );

    void onGestureTap() {
      if (_lock || _forceLock || _disabled) return;
      if (!_forceLock) _startLockTimer();
      onTap?.call();
    }

    final connectOnTap = onTap != null ? onGestureTap : null;

    if (widget.enabledInkWell) {
      final borderRadius = (decBorderRadius is BorderRadius)
          ? decBorderRadius
          : null;
      return Container(
        margin: margin,
        child: LeafInkWell(
          decoration: decoration,
          borderRadius: borderRadius,
          disabled: _disabled,
          onTap: connectOnTap,
          child: childWidget,
        ),
      );
    }

    return GestureDetector(
      onTap: connectOnTap,
      child: Container(
        decoration: decoration,
        margin: margin,
        child: childWidget,
      ),
    );
  }

  void _startLockTimer() {
    _toggleLoading(true);
    _lock = true;
    _timer?.cancel();
    _timer = Timer(widget.duration, () {
      _toggleLoading(false);
      _lock = false;
    });
  }

  void _stopLockTimer() {
    _toggleLoading(false);
    _timer?.cancel();
    _timer = null;
  }

  void _toggleLoading(bool loading) {
    if (context.mounted) {
      setState(() {
        _loading = loading;
      });
    }
  }
}
