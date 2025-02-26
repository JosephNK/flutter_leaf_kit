import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class TabBarScreen extends ScreenStatefulWidget {
  final String title;

  const TabBarScreen({
    super.key,
    required this.title,
  });

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends ScreenState<TabBarScreen>
    with TickerProviderStateMixin {
  @override
  Color? get backgroundColor => Colors.white;

  late TabController _tabController1;
  late TabController _tabController2;

  @override
  void initState() {
    super.initState();

    _tabController1 = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController1.addListener(() async {
      if (!_tabController1.indexIsChanging) {
        final index = _tabController1.index;
        debugPrint('TabBarScreen TabController(1) index: $index');
      }
    });

    _tabController2 = TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController2.addListener(() async {
      if (!_tabController2.indexIsChanging) {
        final index = _tabController2.index;
        debugPrint('TabBarScreen TabController(2) index: $index');
      }
    });
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();

    super.dispose();
  }

  @override
  Widget? buildScreen(BuildContext context) {
    return buildScaffold(context, null);
  }

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, Object? state) {
    return LFAppBar(
      title: LFAppBarTitle(text: widget.title),
    );
  }

  @override
  Widget buildBody(BuildContext context, Object? state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetTile(
              title: 'LFTabBar',
              child: LFTabBar(
                controller: _tabController1,
                tabs: const [
                  Tab(child: Text('상품 정보')),
                  Tab(child: Text('리뷰')),
                  Tab(child: Text('주의사항')),
                ],
              ),
            ),
            WidgetTile(
              title: 'TabBar',
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        controller: _tabController2,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.black,
                        labelStyle: const TextStyle(
                          // fontFamily: 'NotoSansJP',
                          fontFamily: 'NotoSansCJK',
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.24,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          // fontFamily: 'NotoSansJP',
                          fontFamily: 'NotoSansCJK',
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.24,
                        ),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerColor: Colors.transparent,
                        isScrollable: true,
                        overlayColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.transparent),
                        tabs: const [
                          Tab(child: Text('상품 정보')),
                          Tab(child: Text('리뷰')),
                          Tab(child: Text('주의사항')),
                          // Tab(child: Text('商品 情報')),
                          // Tab(child: Text('レビュー')),
                          // Tab(child: Text('注意事項')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class TextAreaView extends StatefulWidget {
  final LFTextFieldController controller;

  const TextAreaView({
    super.key,
    required this.controller,
  });

  @override
  State<TextAreaView> createState() => _TextAreaViewState();
}

class _TextAreaViewState extends State<TextAreaView> {
  int _textCount = 0;

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LFTextField(
          controller: controller,
          placeHolder: 'TextArea Typing..',
          // keyboardType: TextInputType.multiline,
          // textInputAction: TextInputAction.newline,
          minLines: 5,
          maxLines: 5,
          maxLength: 11,
          counterText: '',
          onChanged: (text) {
            final text_ = controller.text;
            setState(() {
              _textCount = controller.text.length;
            });
            debugPrint('LFTextField onChanged: $text, $text_');
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${_textCount.toString()}/11'),
        ),
      ],
    );
  }
}
