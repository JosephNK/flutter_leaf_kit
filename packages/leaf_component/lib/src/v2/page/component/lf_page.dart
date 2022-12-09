part of lf_page;

class LFPageView extends StatefulWidget {
  final List<Widget> children;
  final int initialPage;
  final bool autoPage;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final ValueChanged<double>? onChanged;

  const LFPageView({
    Key? key,
    required this.children,
    this.initialPage = 0,
    this.autoPage = false,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    this.onChanged,
  }) : super(key: key);

  @override
  State<LFPageView> createState() => _LFPageViewState();
}

class _LFPageViewState extends State<LFPageView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  double _currentPageValue = 0.0;
  bool _animated = false;

  @override
  void initState() {
    super.initState();

    final initialPage = widget.initialPage;
    final autoPage = widget.autoPage;
    final children = widget.children;
    final onChanged = widget.onChanged;
    final total = children.length;

    /// PageController
    _pageController = PageController(
      initialPage: initialPage,
      viewportFraction: 1,
      keepPage: true,
    );
    _pageController.addListener(() {
      final page = _pageController.page ?? 0.0;
      setState(() => _currentPageValue = page);
      onChanged?.call(page);
    });

    /// AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animationController.addListener(() async {
      if (!autoPage) return;
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();

        final page = total.toDouble() - 1;
        if (_currentPageValue < page) {
          _currentPageValue++;
        } else {
          _currentPageValue = 0;
        }
        setState(() => _animated = true);
        await Future.delayed(const Duration(milliseconds: 300));
        _pageController.jumpToPage(_currentPageValue.toInt());
        setState(() => _animated = false);
        await Future.delayed(const Duration(milliseconds: 300));

        _animationController.forward();
      }
    });
    if (autoPage) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = widget.padding;
    final margin = widget.margin;

    return Container(
      padding: padding,
      margin: margin,
      child: Stack(
        // fit: StackFit.expand,
        children: [
          _buildPageView(context),
          _buildPageIndicator(context),
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    final children = widget.children;
    final autoPage = widget.autoPage;
    final total = children.length;

    final pageViewWidget = ExpandablePageView.builder(
      controller: _pageController,
      physics: const ClampingScrollPhysics(),
      itemCount: total,
      itemBuilder: (context, index) {
        return children[index];
      },
    );

    final animationWidget = AnimatedOpacity(
      opacity: !_animated ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: pageViewWidget,
    );

    return Positioned(
      child: !autoPage ? pageViewWidget : animationWidget,
    );
  }

  Widget _buildPageIndicator(BuildContext context) {
    final children = widget.children;
    final total = children.length;

    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 5.0,
      child: LFPageIndicator(
        total: total,
        current: _currentPageValue.toDouble(),
        activeColor: Colors.pinkAccent,
      ),
    );
  }
}
