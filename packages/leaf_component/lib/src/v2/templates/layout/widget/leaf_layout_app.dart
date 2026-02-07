import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../atoms/indicator/widget/leaf_indicator.dart';

/// Callback invoked when the layout constraints are available.
///
/// The host should call [onBuilder] to signal that the app is ready.
typedef LeafLayoutAppOnSetupDevice = void Function(VoidCallback onBuilder);

/// A root-level layout widget that waits for non-zero constraints before
/// building the main content.
///
/// Uses [LeafTheme] for theming and [LeafIndicator] as loading placeholder.
///
/// Style resolution order:
///   1. Explicit [backgroundColor]
///   2. [LeafThemeData.colors.background]
@immutable
class LeafLayoutApp extends StatefulWidget {
  /// The main content widget displayed once constraints are available.
  final Widget child;

  /// An optional build flavour label (e.g. "DEV", "STAGING").
  ///
  /// When non-empty a [Banner] is rendered at the top-start corner.
  final String buildName;

  /// Background colour for the layout container.
  final Color? backgroundColor;

  /// Optional device setup callback.
  ///
  /// When provided, [onSetupDevice] receives [onBuilder] so the host can
  /// perform platform-specific initialisation before signalling readiness.
  final LeafLayoutAppOnSetupDevice? onSetupDevice;

  /// Called once the layout is ready (non-zero constraints detected).
  final VoidCallback onBuilder;

  const LeafLayoutApp({
    super.key,
    required this.child,
    this.buildName = '',
    this.backgroundColor,
    this.onSetupDevice,
    required this.onBuilder,
  });

  @override
  State<LeafLayoutApp> createState() => _LeafLayoutAppState();
}

class _LeafLayoutAppState extends State<LeafLayoutApp> {
  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;

    final resolvedBg = widget.backgroundColor ?? colors.background;

    final content = LayoutBuilder(
      builder: (_, constraints) {
        return OrientationBuilder(
          builder: (_, _) {
            if (constraints.maxWidth != 0) {
              final onSetupDevice = widget.onSetupDevice;
              if (onSetupDevice != null) {
                onSetupDevice.call(widget.onBuilder);
              } else {
                widget.onBuilder.call();
              }
              return Container(
                color: resolvedBg,
                child: widget.child,
              );
            }
            return const Center(child: LeafIndicator());
          },
        );
      },
    );

    if (widget.buildName.isNotEmpty) {
      return Banner(
        message: widget.buildName,
        location: BannerLocation.topStart,
        child: content,
      );
    }

    return content;
  }
}
