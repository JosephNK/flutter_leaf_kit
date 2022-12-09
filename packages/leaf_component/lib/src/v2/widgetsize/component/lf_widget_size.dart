part of lf_widget_size;

typedef OnWidgetSizeChange = void Function(Size size);

class LFWidgetRenderObject extends RenderProxyBox {
  Size? oldSize;
  OnWidgetSizeChange onChange;

  LFWidgetRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class LFWidgetSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const LFWidgetSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return LFWidgetRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant LFWidgetRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}
