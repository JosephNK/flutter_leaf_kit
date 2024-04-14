import 'package:flutter/material.dart';
import 'package:flutter_leaf_kit/flutter_leaf_kit.dart';

import '../services/responses/responses.dart';
import '../services/services/currency_dio_service.dart';
import '../services/services/products_dio_service.dart';
import '../services/services/reviews_dio_service.dart';

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
  @override
  Color? get backgroundColor => Colors.white;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // HTTP Init
      LFHttpDio.shared.init(
        baseUrl: Uri.parse('https://xxx.xxx.xxx'),
        responseSerializers: responseMergedSerializers,
        jsonUndefinedKey: LFDioBuiltValueJSONUndefinedKey(
          collectionKey: 'items',
          objectKey: 'item',
        ),
        services: [
          ProductsDioService(),
          ReviewsDioService(),
          CurrencyDioService(),
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
              _action1();
            },
            child: const Text('TEST 1'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _action2();
            },
            child: const Text('TEST 2'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(150, 80),
            ),
            onPressed: () {
              _action3();
            },
            child: const Text('TEST 3'),
          ),
        ],
      ),
    );
  }

  Future<void> _action1() async {
    try {
      final apiService = LFHttpDio.shared.getService<ProductsDioService>();
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

  Future<void> _action2() async {
    try {
      final apiService = LFHttpDio.shared.getService<ReviewsDioService>();
      final response = await apiService.get();
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

  Future<void> _action3() async {
    try {
      final apiService = LFHttpDio.shared.getService<CurrencyDioService>();
      final response = await apiService.get();
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
}
