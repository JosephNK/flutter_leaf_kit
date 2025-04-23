import 'package:example/src/common/widget_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/repository.dart';
import '../services/responses/responses.dart';
import '../services/services/products_dio_service.dart';
import '../services/services/profile_dio_service.dart';
import '../services/services/trail_api_dio_service.dart';

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

  late LFHttpDio _httpDio1;
  late LFHttpDio _httpDio2;

  final NetworkRepository _networkRepository = NetworkRepository();

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
      _httpDio1 = LFHttpDio().init(
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

      _httpDio2 = LFHttpDio().init(
        baseUrl: Uri.parse('http://10.10.20.64:3000'),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        responseSerializers: responseMergedSerializers,
        // jsonUndefinedKey: LFDioBuiltValueJSONUndefinedKey(
        //   collectionKey: 'items',
        //   objectKey: 'item',
        // ),
        services: [
          TrailApiDioService(),
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
          WidgetTile(
            title: 'Get Test (dummyjson)',
            child: LFButton(
              text: 'Get Test',
              onTap: () {
                _networkRepository.getProductAll(_httpDio1);
              },
            ),
          ),
          WidgetTile(
            title: 'Timeout Test (Trail)',
            child: LFButton(
              text: 'Timeout Test (Trail)',
              onTap: () {
                _networkRepository.getTimeout(_httpDio2);
              },
            ),
          ),
          WidgetTile(
            title: 'Notfound Test (Trail)',
            child: LFButton(
              text: 'Notfound Test (Trail)',
              onTap: () {
                _networkRepository.getNotfound(_httpDio2);
              },
            ),
          ),
          WidgetTile(
            title: 'Serializer Error Test (Trail)',
            child: LFButton(
              text: 'Serializer Test (Trail)',
              onTap: () {
                _networkRepository.getSerializerError(_httpDio2);
              },
            ),
          ),
          WidgetTile(
            title: 'Multipart Test',
            child: LFButton(
              text: 'Multipart Test',
              onTap: () {
                _networkRepository.postProductAdd(_httpDio1, files: _files);
              },
            ),
          ),
          WidgetTile(
            title: 'Get Profile Test',
            child: LFButton(
              text: 'Get Profile Test',
              onTap: () {
                _networkRepository.getProfileMe(_httpDio1);
              },
            ),
          ),
          WidgetTile(
            title: 'Add ImageFile Test',
            child: Column(
              children: [
                LFButton(
                  text: 'Add ImageFile Test',
                  onTap: () {
                    _addImage();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LFText('${_files.length} Files'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      debugPrint('Network_error: $e');
    }
  }
}
