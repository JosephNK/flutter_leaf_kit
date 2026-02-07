import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';

/// A themed push notification overlay widget.
///
/// Slides down from the top of the screen with an animated opacity.
/// Auto-dismisses after a configurable duration.
///
/// Style resolution order:
///   1. Explicit parameters ([boxDecoration], [titleTextStyle], etc.)
///   2. [LeafNotificationThemeData] from the nearest [LeafTheme]
///   3. Hardcoded defaults
class LeafPushNotification {
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final ValueChanged<Map<String, dynamic>?>? onTap;
  final Widget? icon;
  final Decoration? boxDecoration;
  final Duration? animationDuration;
  final Duration autoDismissDuration;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;

  LeafPushNotification({
    required this.title,
    this.body,
    this.data,
    this.onTap,
    this.icon,
    this.boxDecoration,
    this.animationDuration,
    this.autoDismissDuration = const Duration(seconds: 5),
    this.titleTextStyle,
    this.bodyTextStyle,
  });

  OverlayEntry? _overlayEntry;
  Timer? _timer;

  /// Show the notification overlay in the given [context].
  void show(BuildContext context) {
    if (_overlayEntry != null) return;

    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final componentTheme = theme.notificationTheme;

    final resolvedAnimDuration = animationDuration ??
        componentTheme?.animationDuration ??
        const Duration(milliseconds: 450);
    final resolvedDecoration = boxDecoration ??
        componentTheme?.boxDecoration ??
        BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: colors.surface,
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(alpha: 0.26),
              blurRadius: 5.0,
              offset: const Offset(2.0, 2.0),
            ),
          ],
        );
    final resolvedTitleStyle = titleTextStyle ??
        componentTheme?.titleTextStyle ??
        TextStyle(
          color: colors.onSurface,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        );
    final resolvedBodyStyle = bodyTextStyle ??
        componentTheme?.bodyTextStyle ??
        TextStyle(
          color: colors.onSurface,
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        );
    final resolvedIconColor =
        componentTheme?.iconColor ?? colors.onSurface;
    final resolvedIconSize = componentTheme?.iconSize ?? 40.0;

    _overlayEntry = OverlayEntry(
      builder: (_) {
        return _LFPushNotificationAnimatedWidgetV2(
          title: title,
          body: body,
          data: data,
          icon: icon ??
              Icon(
                Icons.notifications,
                color: resolvedIconColor,
                size: resolvedIconSize,
              ),
          boxDecoration: resolvedDecoration,
          animationDuration: resolvedAnimDuration,
          titleTextStyle: resolvedTitleStyle,
          bodyTextStyle: resolvedBodyStyle,
          onTap: (tapData) {
            closeOverlay();
            onTap?.call(tapData);
          },
        );
      },
    );

    Navigator.of(context).overlay?.insert(_overlayEntry!);

    _timer = Timer(autoDismissDuration, () {
      closeOverlay();
    });
  }

  /// Remove the notification overlay.
  void closeOverlay() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _LFPushNotificationAnimatedWidgetV2 extends StatefulWidget {
  final String title;
  final String? body;
  final Map<String, dynamic>? data;
  final ValueChanged<Map<String, dynamic>?>? onTap;
  final Widget icon;
  final Decoration boxDecoration;
  final Duration animationDuration;
  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;

  const _LFPushNotificationAnimatedWidgetV2({
    required this.title,
    this.body,
    this.data,
    this.onTap,
    required this.icon,
    required this.boxDecoration,
    required this.animationDuration,
    required this.titleTextStyle,
    required this.bodyTextStyle,
  });

  @override
  State<_LFPushNotificationAnimatedWidgetV2> createState() =>
      _LFPushNotificationAnimatedWidgetV2State();
}

class _LFPushNotificationAnimatedWidgetV2State
    extends State<_LFPushNotificationAnimatedWidgetV2> {
  bool _isVisible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });

    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isVisible = false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _isVisible ? 50.0 : 0.0,
      left: 16.0,
      right: 16.0,
      duration: widget.animationDuration,
      child: AnimatedOpacity(
        duration: widget.animationDuration,
        opacity: _isVisible ? 1.0 : 0.0,
        child: Semantics(
          label: 'Notification: ${widget.title}',
          liveRegion: true,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () => widget.onTap?.call(widget.data),
              child: Container(
                decoration: widget.boxDecoration,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    widget.icon,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                              ),
                              child: Text(
                                widget.title,
                                style: widget.titleTextStyle,
                                maxLines: 1,
                              ),
                            ),
                            if (widget.body != null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                                child: Text(
                                  widget.body!,
                                  style: widget.bodyTextStyle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
