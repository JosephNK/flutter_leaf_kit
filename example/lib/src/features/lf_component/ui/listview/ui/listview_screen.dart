import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ListViewScreen extends ScreenStatefulWidget {
  final String title;

  const ListViewScreen({
    super.key,
    required this.title,
  });

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends ScreenState<ListViewScreen> {
  final LFListViewController _listViewController = LFListViewController();

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
    return LFListView<int>(
      controller: _listViewController,
      items: List<int>.generate(30, (i) => i + 1),
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
