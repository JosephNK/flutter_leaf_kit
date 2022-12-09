part of leaf_mixin;

abstract class ListAutoScrollProvider {
  void loadMore();
  void didScroll(ScrollPosition position);
}

mixin ListAutoScrollMixin<T extends StatefulWidget> on State<T>
    implements ListAutoScrollProvider {
  static const _scrollDelta = 150.0;

  late AutoScrollController autoScrollController;

  late bool loading;
  late bool hasReachedMax;
  late bool showTopButton;

  int scrollAutoIndex = 0;

  @override
  void initState() {
    super.initState();

    loading = false;
    hasReachedMax = false;
    showTopButton = false;

    autoScrollController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);

    autoScrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    autoScrollController.dispose();

    super.dispose();
  }

  void _handleScroll() async {
    if (!autoScrollController.hasClients) {
      return;
    }
    final position = autoScrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    setState(() => showTopButton = !(currentScroll <= 10.0));
    didScroll(autoScrollController.position);
    if (loading) return;
    if (maxScroll - currentScroll <= _scrollDelta && hasReachedMax == false) {
      loadMore();
    }
  }

  void scrollToTop({bool animated = false}) {
    if (!autoScrollController.hasClients) {
      return;
    }
    if (animated) {
      autoScrollController.animateTo(1.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
    } else {
      autoScrollController.jumpTo(1.0);
    }
  }

  Future<void> scrollToIndex(int index,
      {Duration duration = Duration.zero}) async {
    await Future.delayed(duration);
    if (!autoScrollController.hasClients || index == 0) {
      return;
    }
    Future.delayed(const Duration(milliseconds: 50), () async {
      await autoScrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
      );
    });
  }
}
