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
  Uint8List? _bytes;
  final String _networkUrl = 'https://picsum.photos/200';
  final String _assetFile = 'assets/images/sample400x300.jpg';

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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Memory'),
            (_bytes != null)
                ? LFTransformImage(
                    image: LFImageValue(
                      bytes: _bytes,
                    ),
                    // width: 100.0,
                    // height: 100.0,
                    // fit: fit,
                    // placeholderWidget: placeholderWidget,
                  )
                : Container(),
            const Text('Network'),
            LFTransformImage(
              image: LFImageValue(
                file: _networkUrl,
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
                file: _assetFile,
              ),
              width: 100.0,
              height: 100.0,
              // fit: fit,
              // placeholderWidget: placeholderWidget,
            )
          ],
        ),
      ),
    );
  }
}
