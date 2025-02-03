import 'dart:io';

import 'package:example/src/common/widget_tile.dart';
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
        WidgetTile(
          title: 'Display File Content',
          child: Text(
            _content,
            textAlign: TextAlign.center,
          ),
        ),
        WidgetTile(
          title: 'Display Status',
          child: Text(
            _status,
            textAlign: TextAlign.center,
          ),
        ),
        WidgetTile(
          title: 'File Write',
          child: LFButton(
            text: 'Write',
            onTap: () async {
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
        ),
        WidgetTile(
          title: 'File Read',
          child: LFButton(
            text: 'Read',
            onTap: () async {
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
        ),
        WidgetTile(
          title: 'File Delete',
          child: LFButton(
            text: 'Delete',
            onTap: () async {
              final documentPath = await LFFileManager.shared
                  .getApplicationDocumentsDirectoryPath();
              final jsonFile = File('$documentPath/test.json');
              final r = await LFFileManager.shared.deleteFile(jsonFile);
              setState(() {
                _status = r ? 'Success Delete' : 'Failed Delete';
              });
            },
          ),
        ),
      ],
    );
  }
}
