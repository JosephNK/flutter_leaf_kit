import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class FileScreen extends ScreenStatefulWidget {
  final String title;

  const FileScreen({
    super.key,
    required this.title,
  });

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends ScreenState<FileScreen> {
  String _content = 'Empty';
  String _status = 'None';

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _content,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 15.0),
        LFFlatButton(
          text: 'Write',
          onPressed: () async {
            final documentPath = await LFFileManager.shared
                .getApplicationDocumentsDirectoryPath();
            final jsonFile = File('$documentPath/test.json');
            const content = {
              'items': [
                {"name": "Kim", "age": 10},
              ]
            };
            final r = await LFFileManager.shared.createOrUpdateFile(
              jsonFile,
              content: content,
              encodeJson: true,
            );
            setState(() {
              _status = r ? 'Success Save' : 'Failed Save';
            });
          },
        ),
        const SizedBox(height: 15.0),
        LFFlatButton(
          text: 'Read',
          onPressed: () async {
            final documentPath = await LFFileManager.shared
                .getApplicationDocumentsDirectoryPath();
            final jsonFile = File('$documentPath/test.json');
            final content = await LFFileManager.shared
                .readAsFile(jsonFile, decodeJson: true);
            setState(() {
              _content = content.toString();
              _status = (content != null) ? 'Success Read' : 'Failed Read';
            });
          },
        ),
        const SizedBox(height: 15.0),
        LFFlatButton(
          text: 'Delete',
          onPressed: () async {
            final documentPath = await LFFileManager.shared
                .getApplicationDocumentsDirectoryPath();
            final jsonFile = File('$documentPath/test.json');
            final r = await LFFileManager.shared.deleteFile(jsonFile);
            setState(() {
              _status = r ? 'Success Delete' : 'Failed Delete';
            });
          },
        ),
        const SizedBox(height: 15.0),
        Text(
          _status,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
