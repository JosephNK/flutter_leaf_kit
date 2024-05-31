import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class GridViewScreen extends ScreenStatefulWidget {
  final String title;

  const GridViewScreen({
    super.key,
    required this.title,
  });

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends ScreenState<GridViewScreen> {
  final LFStaggeredGridViewController _gridViewController =
      LFStaggeredGridViewController();

  @override
  Color? get backgroundColor => Colors.white;

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
    return LFStaggeredGridView<int>(
      controller: _gridViewController,
      items: List<int>.generate(20, (i) => i + 1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 12.0,
      ),
      padding: const EdgeInsets.all(16.0),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      onRefresh: () async {
        debugPrint('onRefresh');
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      onLoadMore: () async {
        debugPrint('onLoadMore');
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      hasReachedMax: false,
      builder: (context, item, index) {
        return Tile(
          index: index,
          extent: (index % 7 + 1) * 30,
        );
      },
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, Object? state) {
    return null;
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.blueAccent,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
