import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';
import '../../../shared/widget/leaf_inkwell.dart';

class LeafAccordionTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final bool expanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final Color? dividerColor;
  final Color? iconColor;
  final EdgeInsets? headerPadding;
  final EdgeInsets? contentPadding;
  final Duration? expandDuration;

  const LeafAccordionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.expanded = false,
    this.onExpansionChanged,
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.dividerColor,
    this.iconColor,
    this.headerPadding,
    this.contentPadding,
    this.expandDuration,
  });

  @override
  State<LeafAccordionTile> createState() => _LeafAccordionTileState();
}

class _LeafAccordionTileState extends State<LeafAccordionTile>
    with TickerProviderStateMixin {
  late final AnimationController _iconController;
  late final AnimationController _sizeController;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _sizeController = AnimationController(
      vsync: this,
      duration: widget.expandDuration ?? const Duration(milliseconds: 250),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _sizeController,
      curve: Curves.fastOutSlowIn,
    );

    if (widget.expanded) {
      _iconController.value = 1.0;
      _sizeController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant LeafAccordionTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.expandDuration != oldWidget.expandDuration) {
      _sizeController.duration =
          widget.expandDuration ?? const Duration(milliseconds: 250);
    }

    if (widget.expanded != oldWidget.expanded) {
      if (widget.expanded) {
        _iconController.forward();
        _sizeController.forward();
      } else {
        _iconController.reverse();
        _sizeController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _iconController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final accordionTheme = theme.accordionTheme;

    final resolvedHeaderBg = widget.headerBackgroundColor ??
        accordionTheme?.headerBackgroundColor ??
        colors.surface;
    final resolvedContentBg = widget.contentBackgroundColor ??
        accordionTheme?.contentBackgroundColor ??
        colors.background;
    final resolvedDividerColor =
        widget.dividerColor ?? accordionTheme?.dividerColor ?? colors.divider;
    final resolvedIconColor =
        widget.iconColor ?? accordionTheme?.iconColor ?? colors.onSurface;
    final resolvedHeaderPadding =
        widget.headerPadding ?? const EdgeInsets.all(16.0);
    final resolvedContentPadding =
        widget.contentPadding ?? const EdgeInsets.all(16.0);

    return Semantics(
      label: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(
            context,
            headerBg: resolvedHeaderBg,
            iconColor: resolvedIconColor,
            headerPadding: resolvedHeaderPadding,
          ),
          Divider(height: 1, thickness: 1, color: resolvedDividerColor),
          _buildContent(
            contentBg: resolvedContentBg,
            contentPadding: resolvedContentPadding,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required Color headerBg,
    required Color iconColor,
    required EdgeInsets headerPadding,
  }) {
    return LeafInkWell(
      onTap: () => widget.onExpansionChanged?.call(!widget.expanded),
      child: Container(
        color: headerBg,
        padding: headerPadding,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: iconColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _iconController,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _iconController.value * -pi,
                  child: child,
                );
              },
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({
    required Color contentBg,
    required EdgeInsets contentPadding,
  }) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: Container(
        color: contentBg,
        width: double.infinity,
        padding: contentPadding,
        child: widget.child,
      ),
    );
  }
}
