import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../common/theme/leaf_theme.dart';
import '../../../atoms/indicator/widget/leaf_page_rect_indicator.dart';

class LeafPageView extends StatefulWidget {
  final List<Widget> children;
  final int initialPage;
  final bool autoPage;
  final bool showIndicator;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Duration? autoPageDuration;
  final Duration? fadeTransitionDuration;
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;
  final Widget Function(int total, double current)? indicatorBuilder;
  final ValueChanged<double>? onPageChanged;

  const LeafPageView({
    super.key,
    required this.children,
    this.initialPage = 0,
    this.autoPage = false,
    this.showIndicator = true,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.autoPageDuration,
    this.fadeTransitionDuration,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.indicatorBuilder,
    this.onPageChanged,
  });

  @override
  State<LeafPageView> createState() => _LeafPageViewState();
}

class _LeafPageViewState extends State<LeafPageView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _autoPageController;

  double _currentPage = 0.0;
  bool _isFading = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: true,
    );
    _pageController.addListener(_onPageScroll);

    _autoPageController = AnimationController(
      vsync: this,
      duration: _resolveAutoPageDuration(),
    );
    _autoPageController.addListener(_onAutoPageTick);

    if (widget.autoPage) {
      _autoPageController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant LeafPageView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newDuration = _resolveAutoPageDuration();
    if (_autoPageController.duration != newDuration) {
      _autoPageController.duration = newDuration;
    }

    if (widget.autoPage && !oldWidget.autoPage) {
      _autoPageController.forward();
    } else if (!widget.autoPage && oldWidget.autoPage) {
      _autoPageController.stop();
      _autoPageController.reset();
    }
  }

  @override
  void dispose() {
    _autoPageController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Duration _resolveAutoPageDuration() {
    if (widget.autoPageDuration != null) return widget.autoPageDuration!;
    // Theme resolution deferred to build; use default here.
    return const Duration(seconds: 3);
  }

  Duration _resolveFadeDuration() {
    if (widget.fadeTransitionDuration != null) {
      return widget.fadeTransitionDuration!;
    }
    return const Duration(milliseconds: 300);
  }

  void _onPageScroll() {
    final page = _pageController.page ?? 0.0;
    setState(() => _currentPage = page);
    widget.onPageChanged?.call(page);
  }

  Future<void> _onAutoPageTick() async {
    if (!widget.autoPage) return;
    if (_autoPageController.status != AnimationStatus.completed) return;

    _autoPageController.reset();

    final total = widget.children.length;
    final lastPage = total - 1;
    final nextPage =
        _currentPage.round() < lastPage ? _currentPage.round() + 1 : 0;

    final fadeDuration = _resolveFadeDuration();

    setState(() => _isFading = true);
    await Future.delayed(fadeDuration);

    if (!mounted) return;
    _pageController.jumpToPage(nextPage);

    setState(() => _isFading = false);
    await Future.delayed(fadeDuration);

    if (!mounted) return;
    _autoPageController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = LeafTheme.of(context);
    final colors = theme.colors;
    final pageViewTheme = theme.pageViewTheme;

    final resolvedActiveColor = widget.indicatorActiveColor ??
        pageViewTheme?.indicatorActiveColor ??
        colors.primary;
    final resolvedInactiveColor = widget.indicatorInactiveColor ??
        pageViewTheme?.indicatorInactiveColor ??
        colors.inactive;

    final total = widget.children.length;

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: Stack(
        children: [
          _buildPageView(),
          if (widget.showIndicator)
            _buildIndicator(
              total: total,
              activeColor: resolvedActiveColor,
              inactiveColor: resolvedInactiveColor,
            ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    final total = widget.children.length;
    final fadeDuration = _resolveFadeDuration();

    final pageView = ExpandablePageView.builder(
      controller: _pageController,
      physics: const ClampingScrollPhysics(),
      itemCount: total,
      itemBuilder: (_, index) => widget.children[index],
    );

    if (!widget.autoPage) return Positioned(child: pageView);

    return Positioned(
      child: AnimatedOpacity(
        opacity: _isFading ? 0.0 : 1.0,
        duration: fadeDuration,
        child: pageView,
      ),
    );
  }

  Widget _buildIndicator({
    required int total,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    final indicator = widget.indicatorBuilder != null
        ? widget.indicatorBuilder!(total, _currentPage)
        : LeafPageRectIndicator(
            total: total,
            current: _currentPage,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
          );

    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 5.0,
      child: indicator,
    );
  }
}
