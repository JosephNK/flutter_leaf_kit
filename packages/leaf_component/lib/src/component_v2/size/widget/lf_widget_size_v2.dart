import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Callback fired when the measured child's position or size changes.
typedef OnWidgetSizeChangeV2 = void Function(Offset position, Size size);

/// A custom [RenderProxyBox] that reports position and size changes
/// after each layout via a post-frame callback.
class LFWidgetRenderObjectV2 extends RenderProxyBox {
  Size? _previousSize;
  Offset? _previousPosition;
  OnWidgetSizeChangeV2 onChange;

  LFWidgetRenderObjectV2(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final childRender = child;
      if (childRender == null) return;

      final newSize = childRender.size;
      final newPosition = childRender.localToGlobal(Offset.zero);

      if (_previousSize == newSize && _previousPosition == newPosition) return;

      _previousSize = newSize;
      _previousPosition = newPosition;
      onChange(newPosition, newSize);
    });
  }
}

/// A widget that measures its [child] and reports size/position changes
/// through [onChange].
///
/// No theme required — this is a utility widget.
@immutable
class LFWidgetSizeV2 extends SingleChildRenderObjectWidget {
  /// Called whenever the child's global position or size changes.
  final OnWidgetSizeChangeV2 onChange;

  const LFWidgetSizeV2({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LFWidgetRenderObjectV2(onChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant LFWidgetRenderObjectV2 renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}
