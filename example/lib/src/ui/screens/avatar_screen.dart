import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class AvatarScreen extends ScreenStatefulWidget {
  final String title;

  const AvatarScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends ScreenState<AvatarScreen> {
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          LFCircleAvatarImage(
            image: 'https://picsum.photos/200/300',
            size: 25,
          ),
          SizedBox(height: 20.0),
          LFCacheImage(
            url: 'https://picsum.photos/150/150',
            // width: 150,
            // height: 150,
          ),
        ],
      ),
    );
  }
}
