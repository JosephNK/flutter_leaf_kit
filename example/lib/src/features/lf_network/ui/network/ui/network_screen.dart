import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../services/responses/responses.dart';
import '../services/services/products_dio_service.dart';
import '../services/services/profile_dio_service.dart';

class NetworkScreen extends ScreenStatefulWidget {
  final String title;

  const NetworkScreen({
    super.key,
    required this.title,
  });

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends ScreenState<NetworkScreen> {
  List<LFMultipartFile> _files = [];

  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final multipartFile = LFMultipartFile.fromXFile(XFile(
            '/data/user/0/com.shop.sazo.test/cache/2cc2858a-6c92-4935-be07-1f8855c9a7ab/Screenshot_20240724_230117_One UI Home.jpg'));
        debugPrint('multipartFile: ${multipartFile.uri}');
        final bytes = multipartFile.getFileBytes();
        debugPrint('bytes: ${bytes?.length}');
      } catch (e) {
        debugPrint('error: $e');
      }

      // HTTP Init
      LFHttpSharedDio.shared.init(
        baseUrl: Uri.parse('https://dummyjson.com'),
        responseSerializers: responseMergedSerializers,
        jsonUndefinedKey: LFDioBuiltValueJSONUndefinedKey(
          collectionKey: 'items',
          objectKey: 'item',
          excludeStructs: [
            {'products': Object()},
          ],
        ),
        services: [
          ProductsDioService(),
          ProfileDioService(),
        ],
      );
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _getAction();
            },
            child: const Text('Get Test'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _postAction();
            },
            child: const Text('Multipart Test'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _getAction1();
            },
            child: const Text('Get Profile Test'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _addImage();
            },
            child: const Text('Add ImageFile Test'),
          ),
          const SizedBox(height: 10.0),
          Text('${_files.length} Files'),
        ],
      ),
    );
  }

  Future<void> _getAction() async {
    try {
      final apiService =
          LFHttpSharedDio.shared.getService<ProductsDioService>();
      final response = await apiService.get(limit: 5);
      if (response.isSuccessful) {
        final body = response.data;
        Logging.d('body: $body');
      } else {
        final error = response.error;
        Logging.e('error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Exception e: $e');
    }
  }

  Future<void> _getAction1() async {
    try {
      final apiService = LFHttpSharedDio.shared.getService<ProfileDioService>();
      final response = await apiService.getProfileMe();
      if (response.isSuccessful) {
        final body = response.data;
        final item = body?.item;
        Logging.d('body: $body');
        Logging.d('item: $item');
      } else {
        final error = response.error;
        Logging.e('error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Exception e: $e');
    }
  }

  Future<void> _postAction() async {
    try {
      final apiService =
          LFHttpSharedDio.shared.getService<ProductsDioService>();
      final response = await apiService.postAdd(
        title: 'Test Title',
        files: _files,
      );
      if (response.isSuccessful) {
        final body = response.data;
        Logging.d('body: $body');
      } else {
        final error = response.error;
        Logging.e('error: $error');
      }
    } on Exception catch (e) {
      Logging.e('Exception e: $e');
    }
  }

  Future<void> _addImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null && context.mounted) {
        final file = LFMultipartFile.fromXFile(image);
        setState(() {
          _files = [..._files, file];
        });
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }
}
