part of leaf_appbar_component;

mixin LeafBottomAppBarDelegate {
  void bottomAppBarTapedWhenVisible();
}

abstract class LeafBottomAppBarScreenWidget extends ControllerStatefulWidget {
  final LeafBottomIndex index;
  final int checkActiveTabIndex;

  const LeafBottomAppBarScreenWidget({
    Key? key,
    required this.index,
    required this.checkActiveTabIndex,
  }) : super(key: key);
}

abstract class LeafBottomAppBarScreenState<
        T extends LeafBottomAppBarScreenWidget> extends ControllerState<T>
    with LeafBottomAppBarDelegate {
  late LeafBottomAppBarDelegate delegate;

  @override
  void initState() {
    super.initState();

    delegate = this;

    isActivation = (widget.index.activeTabIndex == widget.checkActiveTabIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    // Once Activation
    if (!isActivation) {
      isActivation =
          (widget.index.activeTabIndex == widget.checkActiveTabIndex);
    }

    // Taped when visible
    if (widget.index.scrollTop) {
      delegate.bottomAppBarTapedWhenVisible();
    }

    super.didUpdateWidget(oldWidget);
  }
}
