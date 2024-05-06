import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

class ImageScreen extends ScreenStatefulWidget {
  final String title;

  const ImageScreen({
    super.key,
    required this.title,
  });

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends ScreenState<ImageScreen> {
  final String _networkUrl = 'https://picsum.photos/300';
  final String _assetFile = 'assets/images/sample400x300.jpg';
  final String _fileUrl = 'file://xxx.xxx';

  Uint8List? _bytes;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bytes = await rootBundle.load('assets/images/sample400x300.jpg');
      setState(() {
        _bytes = bytes.buffer.asUint8List();
      });
    });
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
    final networkUri = Uri.parse(_networkUrl);
    final assetFileUri = Uri.parse(_assetFile);
    final fileUri = Uri.parse(_fileUrl);
    final emptyUri = Uri.parse('');

    // flutter: networkUri: https://picsum.photos/200
    // flutter: assetFileUri: assets/images/sample400x300.jpg
    // flutter: fileUri: file://image.png/
    // flutter: emptyUri:
    // flutter: networkUri (scheme): https
    // flutter: assetFileUri (scheme):
    // flutter: fileUri (scheme): file
    // flutter: emptyUri (scheme):
    // flutter: networkUri (path): /200
    // flutter: assetFileUri (path): assets/images/sample400x300.jpg
    // flutter: fileUri (path): /
    // flutter: emptyUri (path):

    debugPrint('networkUri: ${networkUri.toString()}');
    debugPrint('assetFileUri: ${assetFileUri.toString()}');
    debugPrint('fileUri: ${fileUri.toString()}');
    debugPrint('emptyUri: ${emptyUri.toString()}');
    debugPrint('networkUri (scheme): ${networkUri.scheme}');
    debugPrint('assetFileUri (scheme): ${assetFileUri.scheme}');
    debugPrint('fileUri (scheme): ${fileUri.scheme}');
    debugPrint('emptyUri (scheme): ${emptyUri.scheme}');
    debugPrint('networkUri (path): ${networkUri.path}');
    debugPrint('assetFileUri (path): ${assetFileUri.path}');
    debugPrint('fileUri (path): ${fileUri.path}');
    debugPrint('emptyUri (path): ${emptyUri.path}');

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Network'),
            LFTransformImage(
              image: LFImageValue(
                origin: networkUri,
                header: null,
              ),
              width: 100.0,
              height: 100.0,
              // fit: fit,
              // placeholderWidget: placeholderWidget,
            ),
            const Text('Assets'),
            LFTransformImage(
              image: LFImageValue(
                origin: assetFileUri,
              ),
              width: 100.0,
              height: 100.0,
              // fit: fit,
              // placeholderWidget: placeholderWidget,
            ),
            const Text('Memory'),
            (_bytes != null)
                ? LFTransformImage(
                    image: LFImageValue(
                      bytes: _bytes,
                    ),
                    width: 100.0,
                    height: 100.0,
                    // fit: fit,
                    // placeholderWidget: placeholderWidget,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
