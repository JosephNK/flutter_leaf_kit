import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class TextScreen extends ScreenStatefulWidget {
  final String title;

  const TextScreen({
    super.key,
    required this.title,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends ScreenState<TextScreen> {
  final String _longText =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('maxLines is 1'),
            ),
            LFText(
              _longText,
              maxLines: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('maxLines is null'),
            ),
            LFText(
              _longText,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
