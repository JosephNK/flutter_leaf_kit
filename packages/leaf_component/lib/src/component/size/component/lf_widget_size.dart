part of '../lf_widget_size.dart';

typedef OnWidgetSizeChange = void Function(Offset position, Size size);

class LFWidgetRenderObject extends RenderProxyBox {
  Size? oldSize;
  Offset? oldPos;
  OnWidgetSizeChange onChange;

  LFWidgetRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size newSize = child!.size;
      Offset newPos = child!.localToGlobal(Offset.zero);
      if (oldSize == newSize && oldPos == newPos) return;
      oldSize = newSize;
      oldPos = newPos;
      onChange(newPos, newSize);
    });
  }
}

class LFWidgetSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const LFWidgetSize({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LFWidgetRenderObject(onChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant LFWidgetRenderObject renderObject,
  ) {
    renderObject.onChange = onChange;
  }
}
