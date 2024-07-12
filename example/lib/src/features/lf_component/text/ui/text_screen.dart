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
    return SingleChildScrollView(
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('LFEasyRichText'),
            ),
            LFEasyRichText(
              'Hello! My Name is Kim',
              patternList: [
                LFEasyRichTextPattern(
                  targetString: 'Kim',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('LFLinkText'),
            ),
            LFLinkText(
              '이용약관 및 개인정보 수집 및 이용에 동의합니다. abc@gmil.com',
              matchTexts: const ['이용약관', '개인정보 수집'],
              maxLines: 2,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                height: 2.0,
              ),
              styleMatches: const TextStyle(
                color: Colors.orange,
                fontSize: 16.0,
                height: 1.1,
              ),
              onTap: (text, id) {
                debugPrint('LFLinkText onTap text: $text, id: $id');
              },
            ),
          ],
        ),
      ),
    );
  }
}
