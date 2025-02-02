import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class TextFieldScreen extends ScreenStatefulWidget {
  final String title;

  const TextFieldScreen({
    super.key,
    required this.title,
  });

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends ScreenState<TextFieldScreen> {
  final _textController1 = LFTextFieldController();
  final _textController2 = LFTextFieldController();
  final _textController3 = LFTextFieldController();
  final _textController4 = LFTextFieldController();
  final _textController5 = LFTextFieldController();
  final _textController6 = LFTextFieldController();

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    // _textController1.text = '12345678901';
    _textController6.text = '1234567890-12345';

    super.initState();
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    _textController5.dispose();
    _textController6.dispose();

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
              title: 'LFTextField (Normal)',
              child: LFTextField(
                controller: _textController1,
                placeHolder: 'Normal Typing..',
                maxLength: 10,
                onChanged: (text) {
                  debugPrint('LFTextField onChanged: $text');
                },
              ),
            ),
            WidgetTile(
              title: 'LFTextField (ReadOnly)',
              child: LFTextField(
                controller: _textController2,
                placeHolder: 'ReadOnly Typing..',
                suffixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.ac_unit),
                ),
                // contentPadding: const EdgeInsets.all(0.0),
                readOnly: true,
              ),
            ),
            WidgetTile(
              title: 'LFTextField (Disabled)',
              child: LFTextField(
                controller: _textController3,
                placeHolder: 'Disabled Typing..',
                disabled: true,
              ),
            ),
            WidgetTile(
              title: 'LFTextField (Error Text)',
              child: LFTextField(
                controller: _textController4,
                placeHolder: 'Error Typing..',
                errorText: 'error message',
                errorTextStyle: const TextStyle(color: Colors.red),
              ),
            ),
            WidgetTile(
              title: 'LFTextField (Error Widget)',
              child: LFTextField(
                controller: _textController5,
                placeHolder: 'Error Typing..',
                errorWidget: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 20.0),
                    Container(
                      color: Colors.red.shade50,
                      child: const Text('Error Widget'),
                    ),
                  ],
                ),
                errorText: null,
              ),
            ),
            WidgetTile(
              title: 'TextAreaView',
              child: TextAreaView(
                controller: _textController6,
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
