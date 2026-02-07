import 'package:flutter/material.dart';

import '../../../../common/theme/theme.dart';
import '../../../atoms/indicator/widget/lf_indicator_v2.dart';

/// Callback invoked when the layout constraints are available.
///
/// The host should call [onBuilder] to signal that the app is ready.
typedef LFLayoutAppOnSetupDeviceV2 = void Function(VoidCallback onBuilder);

/// A root-level layout widget that waits for non-zero constraints before
/// building the main content.
///
/// Key differences from V1:
/// * No [LFComponentConfigure] dependency – uses [LFTheme] instead.
/// * No `leaf_common` dependency (no `isNotEmpty` helper).
/// * Uses [LFIndicatorV2] as loading placeholder.
///
/// Style resolution order:
///   1. Explicit [backgroundColor]
///   2. [LFThemeData.colors.background]
@immutable
class LFLayoutAppV2 extends StatefulWidget {
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
  final LFLayoutAppOnSetupDeviceV2? onSetupDevice;

  /// Called once the layout is ready (non-zero constraints detected).
  final VoidCallback onBuilder;

  const LFLayoutAppV2({
    super.key,
    required this.child,
    this.buildName = '',
    this.backgroundColor,
    this.onSetupDevice,
    required this.onBuilder,
  });

  @override
  State<LFLayoutAppV2> createState() => _LFLayoutAppV2State();
}

class _LFLayoutAppV2State extends State<LFLayoutAppV2> {
  @override
  Widget build(BuildContext context) {
    final theme = LFTheme.of(context);
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
            return const Center(child: LFIndicatorV2());
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
