part of leaf_mixin;

// ref.,
// https://medium.com/flutter-community/keeping-flutter-widgets-dry-with-dart-mixins-252cada41217

abstract class FetchProvider {
  void loadMore();
  void didScroll(ScrollPosition position);
}

mixin ListScreenMixin<T extends StatefulWidget> on State<T>
    implements FetchProvider {
  //static const _scrollDelta = 200.0;
  static const _scrollDelta = 10.0;

  ScrollController scrollController = ScrollController();

  late bool loading;
  late bool hasReachedMax;
  late bool showTopButton;

  @override
  void initState() {
    super.initState();

    loading = false;
    hasReachedMax = false;
    showTopButton = false;

    scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_handleScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() async {
    final position = scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    setState(() => showTopButton = !(currentScroll <= 10.0));
    didScroll(scrollController.position);
    if (loading) return;
    if (maxScroll - currentScroll <= _scrollDelta && hasReachedMax == false) {
      loadMore();
    }
  }

  void scrollToTop({bool animated = false}) {
    if (animated) {
      scrollController.animateTo(1.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 100));
    } else {
      scrollController.jumpTo(1.0);
    }
  }
}
